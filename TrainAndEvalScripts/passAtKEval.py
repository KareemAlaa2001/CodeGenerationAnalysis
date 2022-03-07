import numpy as np


# code taken directly from [(Chen et. al, 2021) Evaluating Large Language Models Trained on Code https://arxiv.org/pdf/2107.03374.pdf]
"""
This is an adaptation from another verion of pass@k where the problem is considered to be solved if any of k samples (per problem) is correct. 
The above method proved to have too much variance, so the below implementation was used instead

To use the below fn as intended, generate n>=k samples per task, count the number of correct samples which pass all unit tests as c
"""
def codex_pass_at_k(n, c, k): 
    """
    :param n: total number of samples
    :param c: number of correct samples
    :param k: k in pass@$k$
    """
    if n - c < k: 
        return 1.0

    return 1.0 - np.prod(1.0 - k /
        np.arange(n - c + 1, n + 1))


# In this paper, they use the original described method of counting a problem as successfully solved when any of k samples is successful
def alphaCode_pass_at_k(n, k):
    pass # TODO

# This handles their other defined metric where rather than
def alphaCode_ten_at_k(n, k):
    pass # TODO 
