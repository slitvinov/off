function emptyp() { return $0 ~ /^[ \t]*$/ }
function strip_comm()   { gsub(/#.*/, "") }

function nl( ) { # next line
    do {
	if (getline < fn == 0) return
	strip_comm()
    } while (emptyp())
}


function pl() { # print a new line
    printf "\n"
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
# awk -f off2ud.awk test_data/rbc.off  > rbc.out.dat
#
# TEST: off2ud.t1
# awk -f off2ud.awk test_data/tetra.off > rbc.out.dat
#
