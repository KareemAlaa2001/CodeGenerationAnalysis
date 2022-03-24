



def print_generated_sample_outputs(sample_outputs, tokenizer):
    print("Output:\n" + 100 * '-')

    for i, sample_output in enumerate(sample_outputs):
        print("{}: {}".format(i, tokenizer.decode(sample_output, skip_special_tokens=True)))
        print(len(sample_output))
