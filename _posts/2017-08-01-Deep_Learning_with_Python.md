---
layout: post
title: Deep Learning with Python
date: 2017-08-01
tag: DL
---


On the other hand, convolution is most typically done with 3x3 windows and no stride (stride 1).

# learning rate
Learning rate is a hyper-parameter that controls how much we are adjusting the weights of our network with respect the loss gradient. The lower the value, the slower we travel along the downward slope. While this might be a good idea (using a low learning rate) in terms of making sure that we do not miss any local minima, it could also mean that we’ll be taking a long time to converge — especially if we get stuck on a plateau region
The following formula shows the relationship.
```
new_weight = existing_weight — learning_rate * gradient
```

Typically learning rates are configured naively at random by the user. At best, the user would leverage on past experiences (or other types of learning material) to gain the intuition on what is the best value to use in setting learning rates.

As such, it’s often hard to get it right. The below diagram demonstrates the different scenarios one can fall into when configuring the learning rate



# most common ways to prevent overfitting in neural networks

1. Get more training data.
2. Reduce the capacity of the network.
3. Add weight regularization.
4. Add dropout

# activation  function
A  function  that  takes  the  input  signal  and  generates  an  output  signal,  but  takes  into  account some  kind  of  threshold  is  called  an  activation  function

# CNN feature map

![feature map](/images/posts/Typical_block diagram_CNN.png)

# state of art AI
https://www.stateoftheart.ai/
