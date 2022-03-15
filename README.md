# CodeGenerationAnalysis
Analysing the performances of different state of the art code generation models on competitive programming tasks using AlphaCode's dataset and evaluation strategy.


## Environment Setup & Dependencies

## CodeContests

### Adding new script to access the data
Each new script must be added to the BUILD file in order to be added to the Bazel workspace. Follow how print_names.and_sources.py is added into that file for analogy.

### Properties of each problem datapoint
First extract each "problem" datapoint analogically to how done in "print_names_and_sources.py". Then access via "problem.____" inside of the "print_names_and_sources.py" script.

* .name
* .description
* .source
* .difficulty
* .public_tests (includes input and output – access via .public_tests[0].input or public_tests[0].output. Note max "n" is 0 here)
* .private_tests (same as public_tests)
* .generated_tests (many, each with .input and .output) 
* .solutions (many separate ones, each includes .language and .solution – access via .solutions[n].language or .solutions[n].solution. Note "n" is the amount of solutions for each problem in this case)
* .incorrect_solutions (many, each with .language and .solution)
* .cf_contest_id
* .cf_index
* .cf_rating
* .cf_tags (couple of separate ones)

The contest_problem.proto file illustrates an example of this structure. Also you can use it to look up the encoding for certain parameters (e.g. source – CODECHEF is .source = 1, CODEFORCES is .source = 2, EASY .difficulty = 1 whilst HARD .difficulty = 3, etc.)


### Understanding the tests
Each problem has input and output values of different types and different sizes. The tests are just different input values matching that problem description format (as specified in the .description) and output values that the solution script should give (in the same format as given in .description).

So to perform a test, run each solution on the test's input, and check if it matches the test's output value.

## CodeT5

[CodeT5 Repository on GitHub](https://github.com/salesforce/CodeT5)

### How we installed and ran their model as is

**Use the [modified code in submodule](https://github.com/allc/MLP-CodeT5/tree/modified)** for easier experiment setup

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
