# CodeGenerationAnalysis
Analysing the performances of different state of the art code generation models on competitive programming tasks using AlphaCode's dataset and evaluation strategy.


## Environment Setup & Dependencies

## CodeContests

## CodeT5

[CodeT5 Repository on GitHub](https://github.com/salesforce/CodeT5)

### How we installed and ran their model as is

1. Clone the repository

    ```bash
    git clone git@github.com:salesforce/CodeT5.git
    ```

2. When Python (Conda) **virtual environment is activated**, install dependencies (using Pytorch with GPU support)
    NOTE: This was done in the mlp virtual environment

    ```bash
    conda install pytorch torchvision cudatoolkit=11.3 -c pytorch
    conda install tqdm tensorboard transformers
    pip install tree_sitter
    ```

3. **Inside the cloned CodeT5 repository folder**, download the pre-trained model and data

    ```bash
    gsutil -m cp -r "gs://sfr-codet5-data-research/pretrained_models" .
    gsutil -m cp -r "gs://sfr-codet5-data-research/data" .
    gsutil -m cp -r "gs://sfr-codet5-data-research/finetuned_models" .
    ```

4. Edit `sh/exp_with_args.sh`, set `WORKDIR` to cloned CodeT5 repository path, might also change the batch size in case CUDA memory is limited

5. If the files were edited on Windows, run

    ```bash
    dos2unix sh/exp_with_args.sh
    ```

6. **Inside `sh` directory**, run fine-tunning

    ```bash
     python run_exp.py --model_tag codet5_base --task concode --sub_task none
     ```

### How to load a fine-tuned instance of the model

## PLBART

## CoTexT

## CodeBERT (if we have the time)