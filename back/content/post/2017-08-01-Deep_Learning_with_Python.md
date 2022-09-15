---
layout: post
title: Deep Learning with Python
date: 2017-08-01
tag: ["DEEPLEARNING"]
categories: ["IT"]
---


On the other hand, convolution is most typically done with 3x3 windows and no stride (stride 1).

# MATPLOTLIB
Matplot is a python library that help us to plot data. The easiest and basic plots are line, scatter and histogram plots.

 * Line plot is better when x axis is time.
 * Scatter is better when there is correlation between two variables
 * Histogram is better when we need to see distribution of numerical data.
 * Customization: Colors,labels,thickness of line, title, opacity, grid, figsize, ticks of axis and linestyle



# How TensorBoard gets data from TensorFlow
The first step in using TensorBoard is acquiring data from your TensorFlow run. For this, you need summary ops. Summary ops are ops, like tf.matmul or tf.nn.relu, which means they take in tensors, produce tensors, and are evaluated from within a TensorFlow graph. However, summary ops have a twist: the Tensors they produce contain serialized protobufs, which are written to disk and sent to TensorBoard. To visualize the summary data in TensorBoard, you should evaluate the summary op, retrieve the result, and then write that result to disk using a summary.FileWriter.

# learning rate
Learning rate is a hyper-parameter that controls how much we are adjusting the weights of our network with respect the loss gradient. The lower the value, the slower we travel along the downward slope. While this might be a good idea (using a low learning rate) in terms of making sure that we do not miss any local minima, it could also mean that we’ll be taking a long time to converge — especially if we get stuck on a plateau region
The following formula shows the relationship.
```
new_weight = existing_weight — learning_rate * gradient
```

Typically learning rates are configured naively at random by the user. At best, the user would leverage on past experiences (or other types of learning material) to gain the intuition on what is the best value to use in setting learning rates.

As such, it’s often hard to get it right. The below diagram demonstrates the different scenarios one can fall into when configuring the learning rate

![learning rate](/img/post/learning_rate.png)


# most common ways to prevent overfitting in neural networks

1. Get more training data.
2. Reduce the capacity of the network.
3. Add weight regularization.
4. Add dropout

# activation  function
A  function  that  takes  the  input  signal  and  generates  an  output  signal,  but  takes  into  account some  kind  of  threshold  is  called  an  activation  function

# CNN feature map

![feature map](/img/post/Typical_block_diagram_CNN.png)

# state of art AI
https://www.stateoftheart.ai/


http://colah.github.io/posts/2014-07-Understanding-Convolutions/

# References
 * [1] https://towardsdatascience.com/understanding-learning-rates-and-how-it-improves-performance-in-deep-learning-d0d4059c1c10
 * [2] http://wubigo.com/2017/01/numpy-notes/
