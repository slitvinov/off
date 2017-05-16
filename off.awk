# a library to read/write off files

function read_header() {
    nl() # skip OFF
    nl(); nv = $1; nf = $2; ne = $3
}

function read_vert(   iv) {
    for (iv = 0; iv < nv; iv++) {
	nl()
	xx[iv] = $1; yy[iv] = $2; zz[iv] = $3
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
    for (iv = 0; iv < nv; iv++)
	print xx[iv], yy[iv], zz[iv]
}

function write_faces(   ifa, nvpf) {
    nvpf = 3
    for (ifa = 0; ifa < nf; ifa++)
	print nvpf, ff0[ifa], ff1[ifa], ff2[ifa]
}

function emptyp() { return $0 ~ /^[ \t]*$/ }
function strip_comm()   { gsub(/#.*/, "") }
function nl( ) { # next line
    do {
	if (getline < fn == 0) return
	strip_comm()
    } while (emptyp())
}
