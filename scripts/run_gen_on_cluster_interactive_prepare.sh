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

mkdir finetuned_models
cp ${CODET5_DATA}/finetuned_models/concode_codet5_base.tar.gz finetuned_models/
cp ${CODET5_DATA}/data_codecontest.tar.gz .
cp ${CODET5_DATA}/pretrained_models.tar.gz .
tar -zxf finetuned_models/concode_codet5_base.tar.gz -C finetuned_models/
tar -zxf data_codecontest.tar.gz
tar -zxf pretrained_models.tar.gz

cd scripts
mkdir output

# time python generate_solutions.py ../data/codecontest/code_contests_test.jsonl output/
# time python generate_solutions.py ../data/codecontest/code_contests_test.jsonl output/ --model_dir ../finetuned_models/concode_codet5_base/

# mkdir -p ${CODET5_EXPERIMENT_SAVE}
# cp output/ ${CODET5_EXPERIMENT_SAVE}/

# rm -r ${TMP}
