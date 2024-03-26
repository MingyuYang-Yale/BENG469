#!/bin/bash
#SBATCH --partition=day
#SBATCH --mail-type=ALL
#SBATCH --job-name=STpipeline
#SBATCH --ntasks=1 --cpus-per-task=16
#SBATCH --mem-per-cpu=8g 
#SBATCH --time=24:00:00


SampleID=50t
INDIR=/vast/palmer/scratch/fan/my393/BENG469/L7
NETID=$1


FW=$INDIR/01.demo_data/50t/50t.R1.fastq.gz
RV=$INDIR/01.demo_data/50t/50t.R2.fastq.gz
MAP=$INDIR/00.database/mm39/STARindex
ANN=$INDIR/00.database/mm39/gencode.vM28.annotation.gtf
CONT=$INDIR/00.database/mm39/STARindex_nc
ID=$INDIR/00.database/barcodes-AB.xls

OUTPUT=/gpfs/gibbs/project/beng469/beng469_$NETID/Lab7-Spatial_transcriptomics/$SampleID
mkdir -p /gpfs/gibbs/project/beng469/beng469_$NETID/Lab7-Spatial_transcriptomics
mkdir -p /gpfs/gibbs/project/beng469/beng469_$NETID/Lab7-Spatial_transcriptomics
mkdir -p /gpfs/gibbs/project/beng469/beng469_$NETID/Lab7-Spatial_transcriptomics/$SampleID
TMP=/gpfs/gibbs/project/beng469/beng469_$NETID/Lab7-Spatial_transcriptomics/$SampleID/tmp
mkdir -p /gpfs/gibbs/project/beng469/beng469_$NETID/Lab7-Spatial_transcriptomics/$SampleID/tmp
EXP=$SampleID

st_pipeline_run.py \
  --output-folder $OUTPUT \
  --temp-folder $TMP \
  --umi-start-position 16 \
  --umi-end-position 26 \
  --ids $ID \
  --ref-map $MAP \
  --ref-annotation $ANN \
  --expName $EXP \
  --htseq-no-ambiguous \
  --verbose \
  --threads 16 \
  --log-file $OUTPUT/${EXP}_log.txt \
  --star-two-pass-mode \
  --no-clean-up \
  --contaminant-index $CONT \
  --disable-clipping \
  --min-length-qual-trimming 30 \
  $FW $RV

convertEnsemblToNames.py \
--annotation $ANN \
--output $OUTPUT/$SampleID\_stdata.updated.tsv $OUTPUT/$SampleID\_stdata.tsv
