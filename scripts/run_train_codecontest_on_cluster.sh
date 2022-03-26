#!/bin/sh


# sbatch  --gres=gpu:2 test2.sh ; squeue

# See comments in run_train_on_cluster_interactive.sh for how to set up


export EXPERIMENT_NAME=train_codecontest

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

cp ${CODET5_DATA}/data_codecontest.tar.gz .
cp ${CODET5_DATA}/pretrained_models.tar.gz .
tar -zxf data_codecontest.tar.gz
tar -zxf pretrained_models.tar.gz

cd sh

python run_exp.py --model_tag codet5_small --task codecontest --sub_task none --data_num 100000 --bs 2

mkdir -p ${CODET5_EXPERIMENT_SAVE}
cp results/ ${CODET5_EXPERIMENT_SAVE}/
cp saved_models/ ${CODET5_EXPERIMENT_SAVE}/
cp tensorboard/ ${CODET5_EXPERIMENT_SAVE}/

rm -r ${TMP}
