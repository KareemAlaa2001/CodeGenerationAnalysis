# CodeGenerationAnalysis
Analysing the performances of different state of the art code generation models on competitive programming tasks using AlphaCode's dataset and evaluation strategy.


## Environment Setup & Dependencies

## CodeContests

## CodeT5

[CodeT5 Repository on GitHub](https://github.com/salesforce/CodeT5)

### How we installed and ran their model as is

**Use the [modified code in submodule](https://github.com/allc/MLP-CodeT5/tree/modified)** for easier experiment setup

1. When Python (Conda) **virtual environment is activated**, install dependencies (using Pytorch with GPU support)

    ```bash
    conda install pytorch torchvision cudatoolkit=11.3 -c pytorch
    conda install tqdm tensorboard transformers
    pip install tree_sitter
    ```

2. **Inside the CodeT5 folder**, download the pre-trained model and data

    ```bash
    gsutil -m cp -r "gs://sfr-codet5-data-research/pretrained_models" .
    gsutil -m cp -r "gs://sfr-codet5-data-research/data" .
    gsutil -m cp -r "gs://sfr-codet5-data-research/finetuned_models" .
    ```

5. If the `sh` files were modified on Windows, run

    ```bash
    dos2unix sh/exp_with_args.sh
    ```

6. **Inside `sh` directory**, run fine-tunning

    ```bash
    python run_exp.py --model_tag codet5_small --task concode --sub_task none
    ```

    Default batch size for this experiment is 32, can specify batch size with `--bs`, e.g. `--bs 4`

### How to load a fine-tuned instance of the model

## PLBART

## CoTexT

## CodeBERT (if we have the time)