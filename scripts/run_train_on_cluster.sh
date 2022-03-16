#!/bin/sh


# sbatch  --gres=gpu:2 test2.sh ; squeue

# See comments in run_train_on_cluster_interactive.sh for how to set up


export EXPERIMENT_NAME=test

export STUDENT_ID=$(whoami)
export CODET5_CODE=/home/${STUDENT_ID}/codet5/MLP-CodeT5.tar.gz
export CODET5_DATA=/home/${STUDENT_ID}/codet5/data
export CODET5_RESULTS=/home/${STUDENT_ID}/codet5/experiments


mkdir -p /disk/scratch/${STUDENT_ID}
export TMPDIR=/disk/scratch/${STUDENT_ID}/
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
cp ${CODET5_DATA}/data.tar.gz .
cp ${CODET5_DATA}/pretrained_models.tar.gz .
tar -zxf finetuned_models.tar.gz
tar -zxf data.tar.gz
tar -zxf pretrained_models.tar.gz

cd sh

python run_exp.py --model_tag codet5_small --task concode --sub_task none

cp results/ ${CODET5_RESULTS}/${EXPERIMENT_NAME}/
cp saved_models/ ${CODET5_RESULTS}/${EXPERIMENT_NAME}/
cp tensorboard/ ${CODET5_RESULTS}/${EXPERIMENT_NAME}/

# rm -r results/
# rm -r saved_models/
# rm -r tensorboard/
rm -r ${TMP}
