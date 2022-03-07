from unittest import skip
from transformers import RobertaTokenizer, T5ForConditionalGeneration
import torch

# setting a seed for result reproduceability
torch.manual_seed(0)

tokenizer = RobertaTokenizer.from_pretrained('Salesforce/codet5-base')
model = T5ForConditionalGeneration.from_pretrained('Salesforce/codet5-base')

text = "def greet(user): print(f'hello <extra_id_0>!')"
input_ids = tokenizer(text, return_tensors="pt").input_ids

def basic_codeT5_example():

    # simply generate a single sequence
    generated_ids = model.generate(input_ids, max_length=8)
    print(generated_ids)
    print(tokenizer.decode(generated_ids[0], skip_special_tokens=True))
    # this prints "{user.username}"

# 
def generation_with_sampling():
    # using both top_p and top_k can avoid very low ranked words while allowing for some dynamic selection
    # adding temperature to generate a sharper probability distribution for more coherent sample generation
    return model.generate(
        input_ids, 
        do_sample=True, 
        max_length=50, 
        top_p=0.95, # dummy example: if the next word probs are "I": 75%, "You": 10%, "We": "5%", etc. etc. with smaller %ages, a value of 0.9 would make the model sample from just these 3 and ignore the rest
        top_k=50, # filter sampling pool to n words
        temperature=0.7,
        num_return_sequences=3 # number of samples to generate
    )

def print_generated_sample_outputs(sample_outputs):
    print("Output:\n" + 100 * '-')

    for i, sample_output in enumerate(sample_outputs):
        print("{}: {}".format(i, tokenizer.decode(sample_output, skip_special_tokens=True)))
    # print("Output:\n" + 100 * '-')
    # print(tokenizer.decode(sample_output[0], skip_special_tokens=True))

sample_outputs = generation_with_sampling()

print_generated_sample_outputs(sample_outputs)


