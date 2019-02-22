---
layout: post
title: machine learning basic
date: 2017-01-03
tag: DeepLearning
---

# Early neural networks
Although the core ideas of neural networks were investigated in toy
forms as early as the 1950s, the approach took decades to really get started. For a long
time, the missing piece was a lack of an efficient way to train large neural networks. This
changed in the mid-1980s, as multiple people independently rediscovered the
"backpropagation" algorithm, a way to train chains of parametric operations using
gradient descent optimization (later in the book, we will go on to precisely define these
concepts), and started applying it to neural networks.
The first successful practical application of neural nets came in 1989 from Bell Labs,
when Yann LeCun combined together the earlier ideas of convolutional neural networks
and backpropagation, and applied them to the problem of handwritten digits
classification. The resulting network, dubbed "LeNet", was used by the US Post Office in
the 1990s to automate the reading of ZIP codes on mail envelopes

# 逻辑回归(Logistic regression)
Logistic regression is a statistical method for analyzing a dataset in which there are one or more independent variables that determine an outcome. The outcome is measured with a dichotomous variable (in which there are only two possible outcomes).

In logistic regression, the dependent variable is binary or dichotomous, i.e. it only contains data coded as 1 (TRUE, success, pregnant, etc.) or 0 (FALSE, failure, non-pregnant, etc.).

The goal of logistic regression is to find the best fitting (yet biologically reasonable) model to describe the relationship between the dichotomous characteristic of interest (dependent variable = response or outcome variable) and a set of independent (predictor or explanatory) variables. Logistic regression generates the coefficients (and its standard errors and significance levels) of a formula to predict a logit transformation of the probability of presence of the characteristic of interest

[https://www.medcalc.org/manual/logistic_regression.php](https://www.medcalc.org/manual/logistic_regression.php)


# 神经网络
一个分类算法，其输出是样本属于某类别的概率值 P(y==k|x;Θ)


# activation function is the sigmoid function
self.activation_function = lambda x: scipy.special.expit(x)
Instead of the usual def() definitions, we use the
magic lambda to create a function there and then, quickly and easily. The function here takes x
and returns scipy.special.expit(x) which is the sigmoid function.
Functions created with lambda are nameless or anonymous, but here we’ve assigned it
to the name self.activation_function(). All this means is that whenever someone needs to user
the activation function, all they need to do is call self.activation_function()
