#!/usr/bin/awk -f

# Convert off [1, 2] to uDeviceX old format
#
# OFF numVertices numFaces numEdges
# x y z
# x y z
# ... numVertices like above
# NVertices v1 v2 v3 ... vN
# MVertices v1 v2 v3 ... vM
# ... numFaces like above

# [1] https://en.wikipedia.org/wiki/OFF_(file_format)
# [2] http://shape.cs.princeton.edu/benchmark/documentation/off_format.html

function nl() { # next line
    getline < fn
}

function pl() { # print a new line
    printf "\n"
}

function emptyp() {
    return $0 ~ /^[ \t]*$/
}

function ini() {
    fn = ARGC < 2 ? "-" : ARGV[1]
}

function read_vert(   iv) {
    for (iv = 0; iv < nv; iv++) {
	nl()
	rr[iv] = $0
    }
}

function read_faces(  ifa, ib) {
    for (ifa = 0; ifa < nf; ifa++) {
	nl(); ib = 2
	ff[ifa] = $(ib++) " " $(ib++) " " $(ib++)
    }
}

function write_header(   ne) {
    nd = ne = 3 * nf / 2 # number of dih; number of edges
    print nv
    print ne
    print nf
    print nd
    pl()
}

function write_vert(   iv) {
    print "Atoms"; pl()
    for (iv = 0; iv < nv; iv++) {
	print iv + 1, 1, 1, rr[iv]
    }
    pl()
}

function write_faces(   ifa) {
    print "Angles"; pl()
    for (ifa = 0; ifa < nf; ifa++) {
	print ifa + 1, 1, ff[ifa]
    }
}

function read_header() {
    nl() # skip OFF
    nl(); nv = $1; nf = $2
}

BEGIN {
    ini()
    read_header()
    read_vert()
    read_faces()

    write_header()
    write_vert()
    write_faces()
}

# TEST: off2ud.t0
# ./off2ud.awk test_data/rbc.off > rbc.out.dat
#
