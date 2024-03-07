#!/usr/bin/awk -f

function init() { fn = ARGC < 2 ? "-" : ARGV[1] }

BEGIN {
    init()
    read_header()
    read_vert()
    read_faces()
    ne = 0 # no edges

    refine()
    bindex()
    build_vert()
    build_faces()

    write_header()
    write_vert()
    write_faces()
}

function build_faces(   k0, k1, k2, f0, f1, f2, iv, ifa) {
    for (ifa = 0; ifa < nf; ifa++) {
	k0 = gg0[ifa]; k1 = gg1[ifa]; k2 = gg2[ifa]
	f0 = idx[k0];  f1 = idx[k1] ; f2 = idx[k2]
	ff0[ifa] = f0; ff1[ifa] = f1; ff2[ifa] = f2
    }
}

function build_vert(   k, iv) {
    for (k in mxx) {
	iv = idx[k]
	xx[iv] = mxx[k]
	yy[iv] = myy[k]
	zz[iv] = mzz[k]
    }
}

function bindex(  k, i) { # build index
    for (k in mxx) idx[k] = i++
    nv = i # vertices
}

function refine() {
    refine_faces()
}

function refine_faces(  ifa) {
    I = 0 # new faces (updated in `reg')
    for (ifa = 0; ifa < nf; ifa++)
	refine_face(ff0[ifa], ff1[ifa], ff2[ifa])
    nf = I
}

function refine_face(a, b, c,   i) {
    reg(s(a),   d(a,b), d(c,a))
    reg(s(b),   d(b,c), d(a,b))
    reg(s(c),   d(c,a), d(b,c))
    reg(d(a,b), d(b,c), d(c,a))
}

function reg(a, b, c) { # register a new face
    gg0[I] = a; gg1[I] = b; gg2[I] = c
    I++
}

function s(i) { # single
    mxx[i] = xx[i]
    myy[i] = yy[i]
    mzz[i] = zz[i]
    return i
}

function d(i, j,  k) { # double
    k = (i < j) ? (i SUBSEP j) : (j SUBSEP i)
    mxx[k] = 1/2*(xx[i] + xx[j])
    myy[k] = 1/2*(yy[i] + yy[j])
    mzz[k] = 1/2*(zz[i] + zz[j])
    return k
}

# TEST: refine.t0
# off.refine test_data/two.off  > re.out.off
#
