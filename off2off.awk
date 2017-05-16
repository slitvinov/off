#!/usr/bin/awk -f

# read and write off [1, 2]
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

function emptyp() { return $0 ~ /^[ \t]*$/ }
function strip_comm()   { gsub(/#.*/, "") }
function nl( ) { # next line
    do {
	if (getline < fn == 0) return
	strip_comm()
    } while (emptyp())
}

function init() {
    fn = ARGC < 2 ? "-" : ARGV[1]
}

function read_header() {
    nl() # skip OFF
    nl(); nv = $1; nf = $2; ne = $3
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
	ff0[ifa] = $(ib++)
	ff1[ifa] = $(ib++)
	ff2[ifa] = $(ib++)	
    }
}

function write_header() {
    print "OFF"
    print nv, nf, ne
}

function write_vert(   iv) {
    for (iv = 0; iv < nv; iv++) print rr[iv]
}

function write_faces(   ifa, nvpf) {
    nvpf = 3
    for (ifa = 0; ifa < nf; ifa++)
	print nvpf, ff0[ifa], ff1[ifa], ff2[ifa]
}

BEGIN {
    init()
    read_header()
    read_vert()
    read_faces()
    ne = 0 # no edges

    write_header()
    write_vert()
    write_faces()
}

# TEST: off2off.t0
# ./off2off.awk test_data/rbc.off > rbc.out.off
#
