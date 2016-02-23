#!/bin/bash -l

#SBATCH -p debug # --partition regular
#SBATCH -N 64 # --nodes 
#SBATCH --ntasks-per-node=32
#SBATCH -t 00:30:00 # --time=00:30:00
#SBATCH -J bb_vpic_io_bench_cori
#DW jobdw capacity=4TB access_mode=striped type=scratch

echo "Running VPIC-IO with 2K processes"

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior

#mkdir /global/cscratch1/sd/sbyna/par-io/vpic_uni_col/output_2K
#lfs setstripe /global/cscratch1/sd/sbyna/par-io/vpic_uni_col/output_2K --count=144 --size=32m
mkdir $DW_JOB_STRIPED/output_2K

srun -n 2048 /global/homes/s/sbyna/research/par-io/io-benchmarks/write/vpicio_uni/vpicio_uni $DW_JOB_STRIPED/output_2K/sample.h5part

#lfs getstripe /global/cscratch1/sd/sbyna/par-io/vpic_uni_col/output_2K/sample.h5part
module load hdf5
ls -l $DW_JOB_STRIPED/output_2K/sample.h5part
ls -lh $DW_JOB_STRIPED/output_2K/sample.h5part
h5dump -H $DW_JOB_STRIPED/output_2K/sample.h5part

