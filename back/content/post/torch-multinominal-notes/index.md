+++
title = "Pytorch multinominal采样函数"
date = 2022-11-30T14:35:01+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AI", "TENSOR"]
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

```
assert(torch.multinomial(weights, 3)[2], tensor(0))
```
 *** 不论试多少次, 0永远都是最后一个被抽到的***


 # 张量数据索引切片与维度变换操作 


```
>>> x = torch.tensor([[[1, 2, 3], [4, 5, 6]],[[7,8,9],[10,11,12]]])
>>> x
tensor([[[ 1,  2,  3],
         [ 4,  5,  6]],

        [[ 7,  8,  9],
         [10, 11, 12]]])
>>> x[0]
tensor([[1, 2, 3],
        [4, 5, 6]])
```

# 按列取数据

```
>>>a = torch.rand(4,4)
>>>b
tensor([[0.0110, 0.7366, 0.9723, 0.1667],
        [0.9848, 0.7190, 0.6564, 0.8766],
        [0.0833, 0.0464, 0.6830, 0.4128],
        [0.6563, 0.5829, 0.2647, 0.3973]])
>>>b[:, :1]
tensor([[0.0110],
        [0.9848],
        [0.0833],
        [0.6563]])
```

 T[ row_start : row_end , column_start:column_end]


 ## 使用select

 ```
>>> a1 = torch.randint(10,(2,2,3))
>>> a1
tensor([[[5, 2, 7],
         [3, 8, 0]],

        [[7, 7, 8],
         [6, 5, 5]]])
>>> a1.select(dim=1,index=0)
tensor([[5, 2, 7],
        [7, 7, 8]])
 ```

 # 张量的维度

有以下几张方法能快速看出张量的维度
 - 维度要看张量的最左边有多少个左中括号，有n个，则这个张量就是n维张量

 - t.shape 在形状的中括号中有多少个数字，就代表这个张量是多少维的张量


 ```
>>> a = torch.randint(10,(2,2,3))
>>> a
tensor([[[2, 6, 8],
         [7, 3, 3]],

        [[2, 0, 0],
         [2, 5, 9]]])
>>> a.shape
torch.Size([2, 2, 3])
>>> a.size(dim=0)
2
>>> a.size(dim=1)
2
>>> a.size(dim=2)
3
 ```



 # 张量的形状

 形状的第一个元素要看张量最外边的中括号中有几个元素
 形状的第二个元素要看张量中最左边的第二个中括号中有几个被逗号隔开的元素
 形状的第二个元素之后的第3,4…n个元素依次类推，分别看第n个中括号中有几个元素即可


 ```
 >>>a = torch.tensor([[[2, 6, 8], [7, 3, 3]],[[2, 0, 0],[2, 5, 9]]])
 >>> a.sum(dim=0)
tensor([[ 4,  6,  8],
        [ 9,  8, 12]])
>>> a.sum(dim=1)
tensor([[ 9,  9, 11],
        [ 4,  5,  9]])
>>> a.sum(dim=2)
tensor([[16, 13],
        [ 2, 16]])

>>> a[:,0:1]
tensor([[[2, 6, 8]],

        [[2, 0, 0]]])
>>> a[:,1:2]
tensor([[[7, 3, 3]],

        [[2, 5, 9]]])
>>> a.sum(dim=1)
tensor([[ 9,  9, 11],
        [ 4,  5,  9]])
```