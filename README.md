Depends on FSL, Freesurfer, AFNI - please acquire relevant licenses and cite appropriately
Creates reports for comparing SWI sequence outputs from the Cornell & Berkeley QSM processing code courtesy of Berkin Bilgic (https://nmr.mgh.harvard.edu/~berkin/index.html), please request this code.

Follows structure used in https://github.com/mrfil/7T-mri-pipeline-hpc, see https://github.com/mrfil/7T-mri-pipeline-hpc/blob/main/setup/file_structure_gen.sh for setup.

Before running this report generator, run steps 1 and 2 of https://github.com/mrfil/7T-mri-pipeline-hpc, followed by https://github.com/mrfil/7T-mri-pipeline-hpc/blob/main/slurm_orig_qsm_stats_rage.sh and https://github.com/mrfil/7T-mri-pipeline-hpc/blob/main/slurm_qsm_stats_rage.sh

usage: ./qsm_method_comparison_report.sh -p <project ID> -s <session ID without "ses-"> -z <subject ID without "sub-"> -b <base file path> -t <version>

Singularity-compatible version available for HPC use - qsm_method_comparison_report_singularity.sh (same usage)
