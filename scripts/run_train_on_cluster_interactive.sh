#!/bin/sh


# Login to a cluster node:
# $ srun --pty bash

# Setup environment on cluster:
# Install conda and activate the virtual environment mlp
# $ conda install pip
# $ pip install torch torchvision
# $ pip install tqdm
# $ pip install transformers
# $ pip install tensorboard
# $ pip install tree_sitter

# Prepare the files on cluster:
# $ git clone https://github.com/allc/MLP-CodeT5.git # might have to do this on the head node, git clone from github seems broken on the cluster, that's why we copy the archive in the next step instead of using git clone
# $ tar -zcf MLP-CodeT5.tar.gz MLP-CodeT5 # put MLP-CodeT5.tar.gz at ${CODET5_CODE}
# Download pre-trained models and data, and create archives (finetuned_models.tar.gz, data.tar.gz, pretrained_models.tar.gz) into ${CODET5_DATA}. For finetuned_models, only include condode, so it takes a lot less time to archive/unarchive and copy the models


#SBATCH -N 1      # nodes requested
#SBATCH -n 1      # tasks requested
#SBATCH --partition=Teach-Standard
#SBATCH --gres=gpu:4
#SBATCH --mem=12000  # memory in Mb
#SBATCH --time=0-08:00:00


export EXPERIMENT_NAME=test

export STUDENT_ID=$(whoami)
export CODET5_CODE=/home/${STUDENT_ID}/codet5/MLP-CodeT5.tar.gz
export CODET5_DATA=/home/${STUDENT_ID}/codet5/data
export CODET5_RESULTS=/home/${STUDENT_ID}/codet5/experiments


# export CUDA_HOME=/opt/cuda-9.0.176.1/

# export CUDNN_HOME=/opt/cuDNN-7.0/

# export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PA$

# export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH

# export CPATH=${CUDNN_HOME}/include:$CPATH

# export PATH=${CUDA_HOME}/bin:${PATH}

# export PYTHON_PATH=$PATH

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

# python run_exp.py --model_tag codet5_small --task concode --sub_task none

# cp results/ ${CODET5_RESULTS}/${EXPERIMENT_NAME}/
# cp saved_models/ ${CODET5_RESULTS}/${EXPERIMENT_NAME}/
# cp tensorboard/ ${CODET5_RESULTS}/${EXPERIMENT_NAME}/

# rm -r results/
# rm -r saved_models/
# rm -r tensorboard/
# rm -r ${TMP}
