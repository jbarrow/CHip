CHip
----

CHip is a CUDA C implementation of the Hippocampal model presented by Professor William Levy. It will be able to handle:

* Trace conditioning
* Sequence recognition

The implemenation is made to be as efficient as possible, but it is an ever-evolving process.

Purpose
-------

MATLAB simulations of the Hippocampus often take all night to run. Ideally, with accelerated, efficient GPU code the required amount of time can be reduced.

Portability
-----------

CHip requires that you have installed CUDA (nvcc) and gcc, and that you are using a newer CUDA-capable GPU (such that the --arch=sm_21 flag will be valid). You can check your GPU compatability on the NVIDIA website.