#!/bin/bash

while getopts :p:s:z:b:t: option; do
	case ${option} in
    	p) export CLEANPROJECT=$OPTARG ;;
    	s) export CLEANSESSION=$OPTARG ;;
    	z) export CLEANSUBJECT=$OPTARG ;;
	b) export based=$OPTARG ;;
	t) export version=$OPTARG ;;
	esac
done
## takes project, subject, and session as inputs

IMAGEDIR=${based}/singularity_images
projDir=${based}/${version}/testing/${CLEANPROJECT}
scripts=${based}/${version}/scripts
stmpdir=${based}/${version}/scratch/stmp/${CLEANSUBJECT}/${CLEANSESSION}
scachedir=${based}/${version}/scratch/scache/${CLEANSUBJECT}/${CLEANSESSION}
mkdir -p ${stmpdir}
mkdir -p ${scachedir}
CACHESING=${scachedir}
TMPSING=${stmpdir}
subject="sub-${CLEANSUBJECT}"
sesname="ses-${CLEANSESSION}"

fignameprefix="sub-${CLEANSUBJECT}_ses-${CLEANSESSION}_desc-QSM"
QSM_REPORT_HTML="${projDir}/bids/derivatives/sub-${CLEANSUBJECT}_ses-${CLEANSESSION}_QSM_REPORT.html"

qsm_resampled="/dataqsm/QSM_to_RAGE.nii.gz"
# perhaps iterate through f values
qsm_orig="/dataqsm/${subject}_${sesname}_ndi_qsm_fp2"


### old method
echo "Generating QC slices for original SWI sequence results" 

temp_slc="/dataqsm/QSM_slc"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif slicer ${qsm_orig} -L -s 1 -i -0.1 0.1 -x 0.3 ${temp_slc}x30.png -x 0.35 ${temp_slc}x35.png -x 0.4 ${temp_slc}x40.png -x 0.45 ${temp_slc}x45.png -x 0.5 ${temp_slc}x50.png -x 0.55 ${temp_slc}x55.png -x 0.6 ${temp_slc}x60.png -x 0.65 ${temp_slc}x65.png -x 0.7 ${temp_slc}x70.png -y 0.3 ${temp_slc}y30.png -y 0.35 ${temp_slc}y35.png -y 0.4 ${temp_slc}y40.png -y 0.45 ${temp_slc}y45.png -y 0.5 ${temp_slc}y50.png -y 0.55 ${temp_slc}y55.png -y 0.6 ${temp_slc}y60.png -y 0.65 ${temp_slc}y65.png -y 0.7 ${temp_slc}y70.png -z 0.3 ${temp_slc}z30.png -z 0.35 ${temp_slc}z35.png -z 0.4 ${temp_slc}z40.png -z 0.45 ${temp_slc}z45.png -z 0.5 ${temp_slc}z50.png -z 0.55 ${temp_slc}z55.png -z 0.6 ${temp_slc}z60.png -z 0.65 ${temp_slc}z65.png -z 0.7 ${temp_slc}z70.png
		
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x30.png + ${temp_slc}x35.png + ${temp_slc}x40.png + ${temp_slc}x45.png + ${temp_slc}x50.png + ${temp_slc}x55.png + ${temp_slc}x60.png + ${temp_slc}x65.png + ${temp_slc}x70.png - ${temp_slc}y30.png + ${temp_slc}y35.png + ${temp_slc}y40.png + ${temp_slc}y45.png + ${temp_slc}y50.png + ${temp_slc}y55.png + ${temp_slc}y60.png + ${temp_slc}y65.png + ${temp_slc}y70.png - ${temp_slc}z30.png + ${temp_slc}z35.png + ${temp_slc}z40.png + ${temp_slc}z45.png + ${temp_slc}z50.png + ${temp_slc}z55.png + ${temp_slc}z60.png + ${temp_slc}z65.png + ${temp_slc}z70.png /dataqsm/${fignameprefix}OLD_native_figure27.png

SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x40.png + ${temp_slc}x50.png + ${temp_slc}x60.png + ${temp_slc}y40.png + ${temp_slc}y50.png + ${temp_slc}y60.png + ${temp_slc}z40.png + ${temp_slc}z50.png + ${temp_slc}z60.png /dataqsm/${fignameprefix}OLD_native_figure9.png

echo "Generating QC slices for original SWI sequence results resampled fMRIPrep preproc-T1w space" 

temp_slc="/dataqsm/QSM_to_RAGE_slc"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif slicer ${qsm_resampled} -L -s 1 -i -0.1 0.1 -x 0.3 ${temp_slc}x30.png -x 0.35 ${temp_slc}x35.png -x 0.4 ${temp_slc}x40.png -x 0.45 ${temp_slc}x45.png -x 0.5 ${temp_slc}x50.png -x 0.55 ${temp_slc}x55.png -x 0.6 ${temp_slc}x60.png -x 0.65 ${temp_slc}x65.png -x 0.7 ${temp_slc}x70.png -y 0.3 ${temp_slc}y30.png -y 0.35 ${temp_slc}y35.png -y 0.4 ${temp_slc}y40.png -y 0.45 ${temp_slc}y45.png -y 0.5 ${temp_slc}y50.png -y 0.55 ${temp_slc}y55.png -y 0.6 ${temp_slc}y60.png -y 0.65 ${temp_slc}y65.png -y 0.7 ${temp_slc}y70.png -z 0.3 ${temp_slc}z30.png -z 0.35 ${temp_slc}z35.png -z 0.4 ${temp_slc}z40.png -z 0.45 ${temp_slc}z45.png -z 0.5 ${temp_slc}z50.png -z 0.55 ${temp_slc}z55.png -z 0.6 ${temp_slc}z60.png -z 0.65 ${temp_slc}z65.png -z 0.7 ${temp_slc}z70.png
		
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x30.png + ${temp_slc}x35.png + ${temp_slc}x40.png + ${temp_slc}x45.png + ${temp_slc}x50.png + ${temp_slc}x55.png + ${temp_slc}x60.png + ${temp_slc}x65.png + ${temp_slc}x70.png - ${temp_slc}y30.png + ${temp_slc}y35.png + ${temp_slc}y40.png + ${temp_slc}y45.png + ${temp_slc}y50.png + ${temp_slc}y55.png + ${temp_slc}y60.png + ${temp_slc}y65.png + ${temp_slc}y70.png - ${temp_slc}z30.png + ${temp_slc}z35.png + ${temp_slc}z40.png + ${temp_slc}z45.png + ${temp_slc}z50.png + ${temp_slc}z55.png + ${temp_slc}z60.png + ${temp_slc}z65.png + ${temp_slc}z70.png /dataqsm/${fignameprefix}OLD_figure27.png

SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x40.png + ${temp_slc}x50.png + ${temp_slc}x60.png + ${temp_slc}y40.png + ${temp_slc}y50.png + ${temp_slc}y60.png + ${temp_slc}z40.png + ${temp_slc}z50.png + ${temp_slc}z60.png /dataqsm/${fignameprefix}OLD_figure9.png

###Aspire 
temp_slc="/dataqsm/QSM_slc_native"
echo "Generating QC slices for Aspire SWI sequence results"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif slicer ${qsm_orig} -L -s 1 -i -0.1 0.1 -x 0.3 ${temp_slc}x30.png -x 0.35 ${temp_slc}x35.png -x 0.4 ${temp_slc}x40.png -x 0.45 ${temp_slc}x45.png -x 0.5 ${temp_slc}x50.png -x 0.55 ${temp_slc}x55.png -x 0.6 ${temp_slc}x60.png -x 0.65 ${temp_slc}x65.png -x 0.7 ${temp_slc}x70.png -y 0.3 ${temp_slc}y30.png -y 0.35 ${temp_slc}y35.png -y 0.4 ${temp_slc}y40.png -y 0.45 ${temp_slc}y45.png -y 0.5 ${temp_slc}y50.png -y 0.55 ${temp_slc}y55.png -y 0.6 ${temp_slc}y60.png -y 0.65 ${temp_slc}y65.png -y 0.7 ${temp_slc}y70.png -z 0.3 ${temp_slc}z30.png -z 0.35 ${temp_slc}z35.png -z 0.4 ${temp_slc}z40.png -z 0.45 ${temp_slc}z45.png -z 0.5 ${temp_slc}z50.png -z 0.55 ${temp_slc}z55.png -z 0.6 ${temp_slc}z60.png -z 0.65 ${temp_slc}z65.png -z 0.7 ${temp_slc}z70.png 
       
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x30.png + ${temp_slc}x35.png + ${temp_slc}x40.png + ${temp_slc}x45.png + ${temp_slc}x50.png + ${temp_slc}x55.png + ${temp_slc}x60.png + ${temp_slc}x65.png + ${temp_slc}x70.png - ${temp_slc}y30.png + ${temp_slc}y35.png + ${temp_slc}y40.png + ${temp_slc}y45.png + ${temp_slc}y50.png + ${temp_slc}y55.png + ${temp_slc}y60.png + ${temp_slc}y65.png + ${temp_slc}y70.png - ${temp_slc}z30.png + ${temp_slc}z35.png + ${temp_slc}z40.png + ${temp_slc}z45.png + ${temp_slc}z50.png + ${temp_slc}z55.png + ${temp_slc}z60.png + ${temp_slc}z65.png + ${temp_slc}z70.png /dataqsm/${fignameprefix}ASPIRE_native_figure27.png

SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x40.png + ${temp_slc}x50.png + ${temp_slc}x60.png + ${temp_slc}y40.png + ${temp_slc}y50.png + ${temp_slc}y60.png + ${temp_slc}z40.png + ${temp_slc}z50.png + ${temp_slc}z60.png /dataqsm/${fignameprefix}ASPIRE_native_figure9.png

temp_slc="/dataqsm/QSM_slc_prep"        
echo "Generating QC slices for Aspire SWI sequence results in resampled fMRIPrep preproc-T1w space"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif slicer ${qsm_resampled} -L -s 1 -i -0.1 0.1 -x 0.3 ${temp_slc}x30.png -x 0.35 ${temp_slc}x35.png -x 0.4 ${temp_slc}x40.png -x 0.45 ${temp_slc}x45.png -x 0.5 ${temp_slc}x50.png -x 0.55 ${temp_slc}x55.png -x 0.6 ${temp_slc}x60.png -x 0.65 ${temp_slc}x65.png -x 0.7 ${temp_slc}x70.png -y 0.3 ${temp_slc}y30.png -y 0.35 ${temp_slc}y35.png -y 0.4 ${temp_slc}y40.png -y 0.45 ${temp_slc}y45.png -y 0.5 ${temp_slc}y50.png -y 0.55 ${temp_slc}y55.png -y 0.6 ${temp_slc}y60.png -y 0.65 ${temp_slc}y65.png -y 0.7 ${temp_slc}y70.png -z 0.3 ${temp_slc}z30.png -z 0.35 ${temp_slc}z35.png -z 0.4 ${temp_slc}z40.png -z 0.45 ${temp_slc}z45.png -z 0.5 ${temp_slc}z50.png -z 0.55 ${temp_slc}z55.png -z 0.6 ${temp_slc}z60.png -z 0.65 ${temp_slc}z65.png -z 0.7 ${temp_slc}z70.png 
       
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x30.png + ${temp_slc}x35.png + ${temp_slc}x40.png + ${temp_slc}x45.png + ${temp_slc}x50.png + ${temp_slc}x55.png + ${temp_slc}x60.png + ${temp_slc}x65.png + ${temp_slc}x70.png - ${temp_slc}y30.png + ${temp_slc}y35.png + ${temp_slc}y40.png + ${temp_slc}y45.png + ${temp_slc}y50.png + ${temp_slc}y55.png + ${temp_slc}y60.png + ${temp_slc}y65.png + ${temp_slc}y70.png - ${temp_slc}z30.png + ${temp_slc}z35.png + ${temp_slc}z40.png + ${temp_slc}z45.png + ${temp_slc}z50.png + ${temp_slc}z55.png + ${temp_slc}z60.png + ${temp_slc}z65.png + ${temp_slc}z70.png /dataqsm/${fignameprefix}ASPIRE_figure27.png

SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x40.png + ${temp_slc}x50.png + ${temp_slc}x60.png + ${temp_slc}y40.png + ${temp_slc}y50.png + ${temp_slc}y60.png + ${temp_slc}z40.png + ${temp_slc}z50.png + ${temp_slc}z60.png /dataqsm/${fignameprefix}ASPIRE_figure9.png

#calculate image difference
echo "Calculating difference between Aspire and original QSM (Aspire - original) in native space"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/aspire,${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/origswi -W /aspire $IMAGEDIR/neurodoc.sif fslmaths /aspire/"${subject}_${sesname}_ndi_qsm_fp2" -sub /origswi/"${subject}_${sesname}_ndi_qsm_fp2" /aspire/${subject}_${sesname}_ndi_qsm_fp2_aspire-original

chmod 777 ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out/*_aspire-original*
echo "Generating QC slices for difference between Aspire and original QSM in native space" 

temp_slc="/dataqsm/QSM_native_diff_slc"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif slicer /dataqsm/${subject}_${sesname}_ndi_qsm_fp2_aspire-original.nii.gz -L -s 1 -x 0.3 ${temp_slc}x30.png -x 0.35 ${temp_slc}x35.png -x 0.4 ${temp_slc}x40.png -x 0.45 ${temp_slc}x45.png -x 0.5 ${temp_slc}x50.png -x 0.55 ${temp_slc}x55.png -x 0.6 ${temp_slc}x60.png -x 0.65 ${temp_slc}x65.png -x 0.7 ${temp_slc}x70.png -y 0.3 ${temp_slc}y30.png -y 0.35 ${temp_slc}y35.png -y 0.4 ${temp_slc}y40.png -y 0.45 ${temp_slc}y45.png -y 0.5 ${temp_slc}y50.png -y 0.55 ${temp_slc}y55.png -y 0.6 ${temp_slc}y60.png -y 0.65 ${temp_slc}y65.png -y 0.7 ${temp_slc}y70.png -z 0.3 ${temp_slc}z30.png -z 0.35 ${temp_slc}z35.png -z 0.4 ${temp_slc}z40.png -z 0.45 ${temp_slc}z45.png -z 0.5 ${temp_slc}z50.png -z 0.55 ${temp_slc}z55.png -z 0.6 ${temp_slc}z60.png -z 0.65 ${temp_slc}z65.png -z 0.7 ${temp_slc}z70.png
		
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x30.png + ${temp_slc}x35.png + ${temp_slc}x40.png + ${temp_slc}x45.png + ${temp_slc}x50.png + ${temp_slc}x55.png + ${temp_slc}x60.png + ${temp_slc}x65.png + ${temp_slc}x70.png - ${temp_slc}y30.png + ${temp_slc}y35.png + ${temp_slc}y40.png + ${temp_slc}y45.png + ${temp_slc}y50.png + ${temp_slc}y55.png + ${temp_slc}y60.png + ${temp_slc}y65.png + ${temp_slc}y70.png - ${temp_slc}z30.png + ${temp_slc}z35.png + ${temp_slc}z40.png + ${temp_slc}z45.png + ${temp_slc}z50.png + ${temp_slc}z55.png + ${temp_slc}z60.png + ${temp_slc}z65.png + ${temp_slc}z70.png /dataqsm/${fignameprefix}ASPIRE-OLD_native_figure27.png

SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x40.png + ${temp_slc}x50.png + ${temp_slc}x60.png + ${temp_slc}y40.png + ${temp_slc}y50.png + ${temp_slc}y60.png + ${temp_slc}z40.png + ${temp_slc}z50.png + ${temp_slc}z60.png /dataqsm/${fignameprefix}ASPIRE-OLD_native_figure9.png

#calculate image difference in preproc space
echo "Calculating difference between Aspire and original QSM (Aspire - original) in resampled fMRIPrep preproc-T1w space"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/aspire,${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/origswi -W /aspire $IMAGEDIR/neurodoc.sif fslmaths /aspire/QSM_to_RAGE.nii.gz -sub /origswi/QSM_to_RAGE.nii.gz /aspire/${subject}_${sesname}_qsm_in_rage_aspire-original

chmod 777 ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out/*_aspire-original*
echo "Generating QC slices for difference between Aspire and original QSM in resampled fMRIPrep preproc-T1w space" 

temp_slc="/dataqsm/QSM_diff_slc"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif slicer /dataqsm/${subject}_${sesname}_qsm_in_rage_aspire-original -L -s 1 -x 0.3 ${temp_slc}x30.png -x 0.35 ${temp_slc}x35.png -x 0.4 ${temp_slc}x40.png -x 0.45 ${temp_slc}x45.png -x 0.5 ${temp_slc}x50.png -x 0.55 ${temp_slc}x55.png -x 0.6 ${temp_slc}x60.png -x 0.65 ${temp_slc}x65.png -x 0.7 ${temp_slc}x70.png -y 0.3 ${temp_slc}y30.png -y 0.35 ${temp_slc}y35.png -y 0.4 ${temp_slc}y40.png -y 0.45 ${temp_slc}y45.png -y 0.5 ${temp_slc}y50.png -y 0.55 ${temp_slc}y55.png -y 0.6 ${temp_slc}y60.png -y 0.65 ${temp_slc}y65.png -y 0.7 ${temp_slc}y70.png -z 0.3 ${temp_slc}z30.png -z 0.35 ${temp_slc}z35.png -z 0.4 ${temp_slc}z40.png -z 0.45 ${temp_slc}z45.png -z 0.5 ${temp_slc}z50.png -z 0.55 ${temp_slc}z55.png -z 0.6 ${temp_slc}z60.png -z 0.65 ${temp_slc}z65.png -z 0.7 ${temp_slc}z70.png
		
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x30.png + ${temp_slc}x35.png + ${temp_slc}x40.png + ${temp_slc}x45.png + ${temp_slc}x50.png + ${temp_slc}x55.png + ${temp_slc}x60.png + ${temp_slc}x65.png + ${temp_slc}x70.png - ${temp_slc}y30.png + ${temp_slc}y35.png + ${temp_slc}y40.png + ${temp_slc}y45.png + ${temp_slc}y50.png + ${temp_slc}y55.png + ${temp_slc}y60.png + ${temp_slc}y65.png + ${temp_slc}y70.png - ${temp_slc}z30.png + ${temp_slc}z35.png + ${temp_slc}z40.png + ${temp_slc}z45.png + ${temp_slc}z50.png + ${temp_slc}z55.png + ${temp_slc}z60.png + ${temp_slc}z65.png + ${temp_slc}z70.png /dataqsm/${fignameprefix}ASPIRE-OLD_figure27.png

SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x40.png + ${temp_slc}x50.png + ${temp_slc}x60.png + ${temp_slc}y40.png + ${temp_slc}y50.png + ${temp_slc}y60.png + ${temp_slc}z40.png + ${temp_slc}z50.png + ${temp_slc}z60.png /dataqsm/${fignameprefix}ASPIRE-OLD_figure9.png

echo "Creating overlay images of Freesurfer parcellation over QSM in resampled fMRIPrep preproc-T1w space"
echo "Original Sequence Overlay"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif overlay 1 0 ${qsm_resampled} -0.1 0.1 /dataqsm/resample_card_"$subject"_"$sesname"_acq-mp2rageunidenoised_desc-aparcaseg_dseg.nii.gz 0 2035 /dataqsm/"$subject"_"$sesname"_resample_card_aparcaseg_dseg_over_qsm_OLD 

echo "Aspire Sequence Overlay"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif overlay 1 0 ${qsm_resampled} -0.1 0.1 /dataqsm/resample_card_"$subject"_"$sesname"_acq-mp2rageunidenoised_desc-aparcaseg_dseg.nii.gz 0 2035 /dataqsm/"$subject"_"$sesname"_resample_card_aparcaseg_dseg_over_qsm_ASPIRE

temp_slc="/dataqsm/QSM_overlay_slc_orig"
echo "Generating QC slices for Freesurfer parcellation overlaid on Original SWI sequence results in resampled fMRIPrep preproc-T1w space"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif slicer /dataqsm/"$subject"_"$sesname"_resample_card_aparcaseg_dseg_over_qsm_OLD -L -s 1 -x 0.3 ${temp_slc}x30.png -x 0.35 ${temp_slc}x35.png -x 0.4 ${temp_slc}x40.png -x 0.45 ${temp_slc}x45.png -x 0.5 ${temp_slc}x50.png -x 0.55 ${temp_slc}x55.png -x 0.6 ${temp_slc}x60.png -x 0.65 ${temp_slc}x65.png -x 0.7 ${temp_slc}x70.png -y 0.3 ${temp_slc}y30.png -y 0.35 ${temp_slc}y35.png -y 0.4 ${temp_slc}y40.png -y 0.45 ${temp_slc}y45.png -y 0.5 ${temp_slc}y50.png -y 0.55 ${temp_slc}y55.png -y 0.6 ${temp_slc}y60.png -y 0.65 ${temp_slc}y65.png -y 0.7 ${temp_slc}y70.png -z 0.3 ${temp_slc}z30.png -z 0.35 ${temp_slc}z35.png -z 0.4 ${temp_slc}z40.png -z 0.45 ${temp_slc}z45.png -z 0.5 ${temp_slc}z50.png -z 0.55 ${temp_slc}z55.png -z 0.6 ${temp_slc}z60.png -z 0.65 ${temp_slc}z65.png -z 0.7 ${temp_slc}z70.png 
       
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x30.png + ${temp_slc}x35.png + ${temp_slc}x40.png + ${temp_slc}x45.png + ${temp_slc}x50.png + ${temp_slc}x55.png + ${temp_slc}x60.png + ${temp_slc}x65.png + ${temp_slc}x70.png - ${temp_slc}y30.png + ${temp_slc}y35.png + ${temp_slc}y40.png + ${temp_slc}y45.png + ${temp_slc}y50.png + ${temp_slc}y55.png + ${temp_slc}y60.png + ${temp_slc}y65.png + ${temp_slc}y70.png - ${temp_slc}z30.png + ${temp_slc}z35.png + ${temp_slc}z40.png + ${temp_slc}z45.png + ${temp_slc}z50.png + ${temp_slc}z55.png + ${temp_slc}z60.png + ${temp_slc}z65.png + ${temp_slc}z70.png /dataqsm/${fignameprefix}OLD_aparcaseg_dseg_overlay_figure27.png

SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi_old/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x40.png + ${temp_slc}x50.png + ${temp_slc}x60.png + ${temp_slc}y40.png + ${temp_slc}y50.png + ${temp_slc}y60.png + ${temp_slc}z40.png + ${temp_slc}z50.png + ${temp_slc}z60.png /dataqsm/${fignameprefix}OLD_aparcaseg_dseg_overlay_figure9.png


temp_slc="/dataqsm/QSM_overlay_slc"
echo "Generating QC slices for Freesurfer parcellation overlaid on Aspire SWI sequence results in resampled fMRIPrep preproc-T1w space"
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif slicer /dataqsm/"$subject"_"$sesname"_resample_card_aparcaseg_dseg_over_qsm_ASPIRE -L -s 1 -x 0.3 ${temp_slc}x30.png -x 0.35 ${temp_slc}x35.png -x 0.4 ${temp_slc}x40.png -x 0.45 ${temp_slc}x45.png -x 0.5 ${temp_slc}x50.png -x 0.55 ${temp_slc}x55.png -x 0.6 ${temp_slc}x60.png -x 0.65 ${temp_slc}x65.png -x 0.7 ${temp_slc}x70.png -y 0.3 ${temp_slc}y30.png -y 0.35 ${temp_slc}y35.png -y 0.4 ${temp_slc}y40.png -y 0.45 ${temp_slc}y45.png -y 0.5 ${temp_slc}y50.png -y 0.55 ${temp_slc}y55.png -y 0.6 ${temp_slc}y60.png -y 0.65 ${temp_slc}y65.png -y 0.7 ${temp_slc}y70.png -z 0.3 ${temp_slc}z30.png -z 0.35 ${temp_slc}z35.png -z 0.4 ${temp_slc}z40.png -z 0.45 ${temp_slc}z45.png -z 0.5 ${temp_slc}z50.png -z 0.55 ${temp_slc}z55.png -z 0.6 ${temp_slc}z60.png -z 0.65 ${temp_slc}z65.png -z 0.7 ${temp_slc}z70.png 
       
SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x30.png + ${temp_slc}x35.png + ${temp_slc}x40.png + ${temp_slc}x45.png + ${temp_slc}x50.png + ${temp_slc}x55.png + ${temp_slc}x60.png + ${temp_slc}x65.png + ${temp_slc}x70.png - ${temp_slc}y30.png + ${temp_slc}y35.png + ${temp_slc}y40.png + ${temp_slc}y45.png + ${temp_slc}y50.png + ${temp_slc}y55.png + ${temp_slc}y60.png + ${temp_slc}y65.png + ${temp_slc}y70.png - ${temp_slc}z30.png + ${temp_slc}z35.png + ${temp_slc}z40.png + ${temp_slc}z45.png + ${temp_slc}z50.png + ${temp_slc}z55.png + ${temp_slc}z60.png + ${temp_slc}z65.png + ${temp_slc}z70.png /dataqsm/${fignameprefix}ASPIRE_aparcaseg_dseg_overlay_figure27.png

SINGULARITY_CACHEDIR=$CACHESING SINGULARITY_TMPDIR=$TMPSING singularity exec --cleanenv --bind ${projDir}/bids/derivatives/swi/${subject}/${sesname}/ndi_out:/dataqsm -W /dataqsm $IMAGEDIR/neurodoc.sif pngappend ${temp_slc}x40.png + ${temp_slc}x50.png + ${temp_slc}x60.png + ${temp_slc}y40.png + ${temp_slc}y50.png + ${temp_slc}y60.png + ${temp_slc}z40.png + ${temp_slc}z50.png + ${temp_slc}z60.png /dataqsm/${fignameprefix}ASPIRE_aparcaseg_dseg_overlay_figure9.png



html="<h1>QSM Report: ${CLEANSUBJECT} ${CLEANSESSION}</h1>"
html+="<p>T1w preprocessing outputs from fMRIPrep used for ROI-based analyses after undergoing afni deoblique and resample to 1mm isotropic space. Processed SWI Magnitude images Intensity Non-Uniformity Corrected with FSL FAST and used for registration of resampled preprocessed brain T1w to SWI space using FLIRT (12 DOF, cost function: normmi). This matrix was then inverted and used to register QSM images to resampled preprocessed brain T1w using FLIRT (sinc interpolation). </p>"
html+="<h2>Native space QSM from Original SWI Sequence</h2>"
html+="<img src=${fignameprefix}OLD_native_figure27.png><br />"
html+="<h2>Native space QSM from Aspire Sequence</h2>"
html+="<img src=${fignameprefix}ASPIRE_native_figure27.png><br />"
html+="<h2>Difference between Native space QSM from Aspire Sequence and Original Sequence</h2>"
html+="<img src=${fignameprefix}ASPIRE-OLD_native_figure27.png><br />"
html+="<h2>fMRIPrep preproc-T1w space QSM from Original SWI Sequence</h2>"
html+="<img src=${fignameprefix}OLD_figure27.png><br />"
html+="<h2>fMRIPrep preproc-T1w space QSM from Aspire Sequence</h2>"
html+="<img src=${fignameprefix}ASPIRE_figure27.png><br />"
html+="<h2>Difference between fMRIPrep preproc-T1w space QSM from Aspire Sequence and Original Sequence</h2>"
html+="<img src=${fignameprefix}ASPIRE-OLD_figure27.png><br />"
html+="<h2>Freesurfer parcellation overlaid on Original SWI sequence results in resampled fMRIPrep preproc-T1w space</h2>"
html+="<img src=${fignameprefix}OLD_aparcaseg_dseg_overlay_figure27.png><br />"
html+="<h2>Freesurfer parcellation overlaid on Aspire SWI sequence results in resampled fMRIPrep preproc-T1w space</h2>"
html+="<img src=${fignameprefix}ASPIRE_aparcaseg_dseg_overlay_figure27.png><br />"

echo $html > ${QSM_REPORT_HTML}

echo "removing images of individual slices used to generate html"
rm ${projDir}/bids/derivatives/sw*/${subject}/${sesname}/ndi_out/*slc* 

