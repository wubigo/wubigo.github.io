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
