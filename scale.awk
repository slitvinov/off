function init() {
    sc = ARGV[1]; shift()
    fn = ARGC < 2 ? "-" : ARGV[1]
}

BEGIN {
    init()
    read_header()
    read_vert()
    read_faces()
    ne = 0 # no edges

    scale()

    write_header()
    write_vert()
    write_faces()
}

function scale(   iv) {
    for (iv = 0; iv < nv; iv++) {
	xx[iv] *= sc; yy[iv] *= sc; zz[iv] *= sc
    }
}

function shift(  i) { for (i = 2; i < ARGC; i++) ARGV[i-1] = ARGV[i]; ARGC-- }

# TEST: scale.t0
# off.scale 42 test_data/rbc.off > scale.out.off
#
