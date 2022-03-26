#!/bin/sh

export EXPERIMENT_NAME=generate_solutions_50x20_base

export STUDENT_ID=$(whoami)
export CODET5_CODE=/home/${STUDENT_ID}/codet5/MLP-CodeT5.tar.gz
export CODET5_DATA=/home/${STUDENT_ID}/codet5/data
export CODET5_EXPERIMENT_SAVE=/home/${STUDENT_ID}/codet5/experiments/${EXPERIMENT_NAME}

mkdir -p /disk/scratch/${STUDENT_ID}
export TMP=/disk/scratch/${STUDENT_ID}/

source /home/${STUDENT_ID}/miniconda3/bin/activate mlp

nvidia-smi
cd ${TMP}
pwd

# git clone https://github.com/allc/MLP-CodeT5.git
cp ${CODET5_CODE} .
tar -zxf MLP-CodeT5.tar.gz
cd MLP-CodeT5

cp ${CODET5_DATA}/finetuned_models.tar.gz .
cp ${CODET5_DATA}/data_codecontest.tar.gz .
cp ${CODET5_DATA}/pretrained_models.tar.gz .
tar -zxf finetuned_models.tar.gz
tar -zxf data_codecontest.tar.gz
tar -zxf pretrained_models.tar.gz

cd sh
mkdir output

# python run_exp.py --model_tag codet5_small --task concode --sub_task none

# mkdir -p ${CODET5_EXPERIMENT_SAVE}
# cp output/ ${CODET5_EXPERIMENT_SAVE}/

# rm -r ${TMP}
