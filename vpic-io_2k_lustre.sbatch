#!/bin/bash -l

#SBATCH -p debug # --partition regular
#SBATCH -N 64 # --nodes 
#SBATCH --ntasks-per-node=32
#SBATCH -t 00:30:00 # --time=00:30:00
#SBATCH -J first_vpic_io_bench_cori


cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior

mkdir /global/cscratch1/sd/sbyna/par-io/vpic_uni_col/output2K
lfs setstripe /global/cscratch1/sd/sbyna/par-io/vpic_uni_col/output2K --count=248 --size=32m

srun -n 2048 /global/homes/s/sbyna/research/par-io/io-benchmarks/write/vpicio_uni/vpicio_uni /global/cscratch1/sd/sbyna/par-io/vpic_uni_col/output2K/sample.h5part

lfs getstripe /global/cscratch1/sd/sbyna/par-io/vpic_uni_col/output2K/sample.h5part
ls -l /global/cscratch1/sd/sbyna/par-io/vpic_uni_col/output2K/sample.h5part
h5dump -H /global/cscratch1/sd/sbyna/par-io/vpic_uni_col/output2K/sample.h5part
rm -rf /global/cscratch1/sd/sbyna/par-io/vpic_uni_col/output2K
