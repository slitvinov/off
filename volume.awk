#!/usr/bin/awk -f

function init() {
    fn = ARGC < 2 ? "-" : ARGV[1]
}

BEGIN {
    init()
    read_header()
    read_vert()
    read_faces()

    print volume()
}

function volume(   ifa, V) {
    V = 0
    for (ifa = 0; ifa < nf; ifa++) {
	f0 = ff0[ifa]; f1 = ff1[ifa]; f2 = ff2[ifa]
	
	x0 = xx[f0]; y0 = yy[f0]; z0 = zz[f0]
	x1 = xx[f1]; y1 = yy[f1]; z1 = zz[f1]
	x2 = xx[f2]; y2 = yy[f2]; z2 = zz[f2]
	V += volume0()
    }
    return V
}

function volume0(   V, ax, ay, az, bx, by, bz) { /* volume of triangle */
    V = ((x0*y1-x1*y0)*z2+(x2*y0-x0*y2)*z1+(x1*y2-x2*y1)*z0)
    V /= 6
    return V
}

