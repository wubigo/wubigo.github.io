+++
title = "Pytorch multinominal采样函数"
date = 2022-11-30T14:35:01+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AI"]
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++

torch.multinominal方法可以根据给定权重对数组进行多次采样，返回采样后的元素下标

参数说明
input ：权重，也就是取每个值的概率，可以是1维或2维。可以不进行归一化。
num_samples ： 采样的次数。如果input是二维的，则表示每行的采样次数
replacement ：默认值值是False，即不放回采样。如果replacement =False，则num_samples必须小于input中非零元素的数目

# 按权重采样

从四个元素中随机选择两个，每个元素被选择到的概率分别为：[0.2, 0.2, 0.3, 0.3]：

```
>>> weights = torch.Tensor([0.9, 0.25, 0.1, 0.15])   # 采样权重
>>> torch.multinomial(weights, 2)
tensor([0, 1])
>>> torch.multinomial(weights, 2)
tensor([1, 3])
>>> torch.multinomial(weights, 2)
tensor([0, 3])
>>> torch.multinomial(weights, 2)
tensor([3, 1])
>>> torch.multinomial(weights, 2)
tensor([1, 0])
>>> torch.multinomial(weights, 2)
tensor([1, 0])
>>> torch.multinomial(weights, 2)
tensor([0, 1])
>>> torch.multinomial(weights, 2)
tensor([0, 2])
>>> torch.multinomial(weights, 2)
tensor([3, 0])
>>> torch.multinomial(weights, 2)
tensor([0, 3])
>>> torch.multinomial(weights, 2)
tensor([0, 1])
>>> torch.multinomial(weights, 2)
tensor([0, 1])
>>> torch.multinomial(weights, 2)
tensor([0, 2])
>>> torch.multinomial(weights, 2)
tensor([0, 3])
```
第0个元素的权重最大，[0...]0被采样的概率最大



# 有放回采样

设置replacement=True，可以进行有放回的采样，此时的n_sample参数可以大于input的长度，
采样对应的索引值放回输出tensor。




# 权重为0的元素

如果是无放回的采样，input中值为0的元素只有在其他元素都被抽到后，才会被抽到；

如果是又放回的采样，input中值为0的元素永远不会被抽到。


```
>>> weights = torch.Tensor([0, 0.3, 0.7])
>>> torch.multinomial(weights, 3)
tensor([2, 1, 0])      
>>> torch.multinomial(weights, 3)
tensor([1, 2, 0])
>>> torch.multinomial(weights, 3)
tensor([1, 2, 0])
>>> torch.multinomial(weights, 3)
tensor([2, 1, 0])
>>> torch.multinomial(weights, 3)
tensor([2, 1, 0])
>>> torch.multinomial(weights, 3)
tensor([2, 1, 0])
>>> torch.multinomial(weights, 3)
tensor([1, 2, 0])
```

 *** 不论试多少次, 0永远都是最后一个被抽到的([...0]) ***