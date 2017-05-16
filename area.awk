#!/usr/bin/awk -f

function init() {
    fn = ARGC < 2 ? "-" : ARGV[1]
}

BEGIN {
    init()
    read_header()
    read_vert()
    read_faces()

    print area()
}

function area(   ifa, A) {
    A = 0
    for (ifa = 0; ifa < nf; ifa++) {
	f0 = ff0[ifa]; f1 = ff1[ifa]; f2 = ff2[ifa]
	
	x0 = xx[f0]; y0 = yy[f0]; z0 = zz[f0]
	x1 = xx[f1]; y1 = yy[f1]; z1 = zz[f1]
	x2 = xx[f2]; y2 = yy[f2]; z2 = zz[f2]
	A += area0()
    }
    return A
}

function area0(   A, ax, ay, az, bx, by, bz) { /* area of triangle */
    ax = x1 - x0; ay = y1 - y0; az = z1 - z0
    bx = x2 - x0; by = y2 - y0; bz = z2 - z0

    #### A = 1/2 * (a x b)
    A = sq(ay*bz-az*by) + sq(az*bx-ax*bz) + sq(ax*by-ay*bx)
    A = sqrt(A)/2
    return A
}

function sq(x) { return x*x }

# TEST: area.t0
# area test_data/rbc.off > area.out.txt
#
