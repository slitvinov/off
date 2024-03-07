# Tools for off files

## Introduction
* [off references](http://www.geomview.org/docs/html/OFF.html)

## Programs
* [off.volume](volume.awk) - compute volume of triangulated surface
* [off.area](area.awk) - compute area of triangulated surface
* [off.scale](scale.awk) - scale coordinates
* [off.refine](refine.awk) - refine triangulated surface

## Install

<pre>
```
$ make
```
</pre>

## Examples
<pre>
$ off.area test_data/icosa.off
3.8298165592841229e+01
$ off.volume test_data/icosa.off
2.0289205728439306e+01
$ off.scale < test_data/icosa.off
*** output flushed ***
</pre>
