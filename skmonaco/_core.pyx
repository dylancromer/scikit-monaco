
cimport numpy as cnp
import numpy as np

cdef void mc_kernel(object f, int npts, int dim, cnp.ndarray[DOUBLE,ndim=2] pts, 
        object args, double* summ, double* sum2):
    cdef :
        int ipt,i
        double val
        cnp.ndarray[DOUBLE,ndim=1] pt = np.empty((dim,))
        double sum_tmp = 0.0, sum2_tmp = 0.0
    for ipt in range(npts):
        for i in range(dim):
            pt[i] = pts[ipt,i]
        val = f(pt,*args)
        sum_tmp += val
        sum2_tmp += val*val
    summ[0] = sum_tmp
    sum2[0] = sum2_tmp

cdef mc_kernel_noargs(object f, int npts, int dim, cnp.ndarray[DOUBLE,ndim=2] pts,
        double* summ, double* sum2):
    cdef :
        int ipt,i
        double val
        cnp.ndarray[DOUBLE,ndim=1] pt = np.empty((dim,))
        double sum_tmp = 0.0, sum2_tmp = 0.0
    for ipt in range(npts):
        for i in range(dim):
            pt[i] = pts[ipt,i]
        val = f(pt)
        sum_tmp += val
        sum2_tmp += val*val
    summ[0] = sum_tmp
    sum2[0] = sum2_tmp

cdef mc_kernel_ret_object_no_args(object f, int npts, int dim, 
        cnp.ndarray[DOUBLE,ndim=2] pts):
    cdef :
        int ipt, i
        object val,summ,sum2
        cnp.ndarray[DOUBLE,ndim=1] pt = np.empty((dim,))
    summ = 0.0
    sum2 = 0.0
    for ipt in range(npts):
        for i in range(dim):
            pt[i] = pts[ipt,i]
        val = f(pt)
        summ += val
        sum2 += val*val
    return summ,sum2

cdef mc_kernel_ret_object(object f, int npts, int dim, 
        cnp.ndarray[DOUBLE,ndim=2] pts, object args):
    cdef :
        int ipt, i
        object val,summ,sum2
        cnp.ndarray[DOUBLE,ndim=1] pt = np.empty((dim,))
    summ = 0.0
    sum2 = 0.0
    for ipt in range(npts):
        for i in range(dim):
            pt[i] = pts[ipt,i]
        val = f(pt,*args)
        summ += val
        sum2 += val*val
    return summ,sum2

