+++
title = "6 Principles of Software Design"
date = 2016-08-25T23:37:04+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["OOP"]
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

# 1. Single Responsibility Principle
Definition:
The single responsibility principle is also known as the single-function principle, that is, there is no more than one reason for the class change. In layman’s terms, a class is only responsible for one responsibility.
Principle:
If a class has too many responsibilities, it is equivalent to coupling these responsibilities together. A change in responsibilities may weaken or continue the ability of this class to perform other duties. This coupling can lead to fragile designs, and when changes occur, the design suffers unexpected damage. And if you want to avoid this happening, you should follow the principle of single responsibility as much as possible. The core of this principle is decoupling and enhancing cohesion.
The origin of the problem:
T is responsible for two different duties: responsibility P1, responsibility P2. When the class T needs to be modified due to the change in the requirement of the responsibility P1, it may cause the P2 function that was originally functioning normally to malfunction. That is to say, duties P1 and P2 are coupled together.
Cause:
No programmer is unclear that high cohesion and low coupling procedures should be written, but many couplings often occur inadvertently because the responsibility spreads , for some reason, a duty is divided into granularity. A lot of responsibilities.
Solution:
Comply with different responsibilities and package different responsibilities into different classes or modules
Advantage:
You can reduce the complexity of a class. A class is only responsible for one responsibility, and its logic is definitely much simpler than being responsible for multiple duties;
Improve the readability of the class and improve the maintainability of the system;
The risk caused by the change is reduced, and the change is inevitable. If the single responsibility principle is followed well, when modifying a function, the impact on other functions can be significantly reduced.

# 2. Liskov Substitution Principle LSP

definition:
One of the basic principles of object-oriented design where any base class can appear, subclasses must appear. LSP is the cornerstone of inheritance and reuse. Only when the derived class can replace the base class, the function of the software unit is not affected, the base class can be truly reused, and the derived class can also add new behavior based on the base class. . (ie, if the parent class is a part of a function module, the child class is used instead of the parent class and the function module can run normally) [The child class instance can replace the parent class instance]
Inheritance contains such a meaning: all methods that have been implemented in the parent class (as opposed to abstract methods) are actually setting a series of specifications and contracts, although it does not mandate that all subclasses must follow these Contracts, but if subclasses arbitrarily modify these non-abstract methods, they will cause damage to the entire inheritance system. The principle of Lee’s replacement is to express this meaning.
Inheritance, as one of the three characteristics of object-oriented, brings great convenience to programming, but also brings disadvantages. For example, using inheritance can bring intrusion to the program, the portability of the program is reduced, and the coupling between objects is increased. If a class is inherited by other classes, all the children must be considered when the class needs to be modified. Classes, and after the parent class is modified, all functions involving subclasses may fail.
The actual situation:
In actual programming, we often complete the new functions by rewriting the methods of the parent class, so that although the writing is simple, the reusability of the whole inheritance system will be poor, especially when the polymorphism is used more frequently. The chances of running an error are very high. If you want to override the method of the parent class, the more common practice is: the original parent class and subclass inherit a more common base class, the original inheritance relationship is removed, and the relationship of dependency, aggregation, combination, etc. is used instead.
Popular meaning:
Subclasses can extend the functionality of the parent class, but not the original function of the parent class.
Subclasses can implement abstract methods of the parent class, but they cannot override the non-abstract methods of the parent class.
Subclasses can add their own unique methods.
When a subclass’s method overrides the parent’s method, the method’s precondition (that is, the method’s formal parameter) is more lenient than the parent class’s input parameter.
When a subclass’s method implements the abstract method of the parent class, the postcondition of the method (that is, the return value of the method) is stricter than the parent class.

# 3. Dependency Inversion Principle
Definition:
High-level modules should not rely on low-level modules, both of which should rely on their abstractions; abstractions should not rely on details; details should rely on abstractions.
The difference:
For process-oriented development, the upper layer calls the lower layer, and the upper layer depends on the lower layer. When the lower layer changes drastically, the upper layer also needs to change, which leads to the reduced reusability of the module and greatly increases the development cost.
Object-oriented development solves this problem very well. In general, the probability of abstract change is small, and the user program depends on abstraction, and the implementation details depend on abstraction. Even if the implementation details are constantly changing, the client program does not need to change as long as the abstraction does not change. This greatly reduces the coupling between the client program and the implementation details.
The origin of the problem:
Class A directly depends on class B. If you want to change class A to dependent class C, you must do so by modifying the code of class A. In this scenario, class A is generally a high-level module responsible for complex business logic; class B and class C are low-level modules that are responsible for basic atomic operations; if class A is modified, it will introduce unnecessary risks to the program.
Solution:
Modify class A to rely on interface I. Class B and class C each implement interface I. Class A indirectly communicates with class B or class C through interface I, which greatly reduces the chance of modifying class A.
The principle of dependency inversion is based on the fact that abstract things (interfaces or abstract classes) are much more stable than the variability of details. Architectures built on abstraction are much more stable than those built on details (specific implementation classes).
There are three ways to pass dependencies, interface passing, constructor passing, and set methods passing
Programming requirements:
Low-level modules should have abstract classes or interfaces, or both.
The declared type of a variable is as much as possible an abstract class or interface.
Follow the principle of Richter replacement when using inheritance.

# 4. Interface Isolation Principle
ISP (ISP — Interface Segregation Principle)
Definition:
The client should not rely on interfaces it does not need; the dependency of one class on another should be based on the smallest interface.
The origin of the problem:
Class A depends on class B through interface I. Class C depends on class D through interface I. If interface I is not the smallest interface for class A and class B, then class B and class D must implement methods they do not need.
Solution:
Split the bloated interface I into separate interfaces, and class A and class C respectively establish dependencies with the interfaces they need. Interface isolation principle
Therefore:
Create a single interface, do not build a large and bloated interface, try to refine the interface, the method in the interface is as small as possible. That is, we need to create a dedicated interface for each class, rather than trying to build a very large interface for all classes that depend on it. 4
Note:
The interface is as small as possible, but limited. Thinning the interface can increase the flexibility of programming. It is not a fact, but if it is too small, it will cause too many interfaces and complicate the design. So be sure to be moderate.
Customizing a service for an interface-dependent class exposes only the methods it needs to the calling class, and the methods it doesn’t need are hidden. Only by focusing on providing a custom service for a module can a minimum dependency be established.
Improve cohesion and reduce external interaction. Make the interface do the most things with the fewest methods.

# 5. Law of Demeter
Definition:
The Law of Demeter is also known as the Least Knowledge Principle (LKP), which means that an object should have as little knowledge as possible about other objects and not speak to strangers. English abbreviated as: LoD.
In layman’s terms, the less a class knows about the class it depends on, the better. That is to say, for the dependent class, no matter how complicated the logic is, the logic is encapsulated inside the class as much as possible, and the public method provided by the external does not leak any information. Another way of saying : only communicate with direct friends
Direct friend:
Classes in member variables, method parameters, method return values,
Indirect friends:
Class in local variables
The origin of the problem:
The closer the relationship between a class and a class, the greater the degree of coupling. When one class changes, the effect on another class is greater.
Solution:
Try to reduce the coupling between classes and classes.
Note:
The original intention of Dimit’s law is to reduce the coupling between classes. Since each class reduces unnecessary dependencies, it can indeed reduce the coupling relationship. But everything has a degree, although it can avoid communication with indirect classes, but to communicate, it is bound to be connected through an “intermediary.” Excessive use of the Dimit principle will result in a large number of such intermediaries and delivery classes, resulting in increased system complexity. Therefore, when using the Dimitte rule, we must repeatedly weigh the balance, so that the structure is clear, but also high cohesion and low coupling.

# 6. Open-Closed Principle
Definition:
A software entity such as classes, modules, and functions should be open to extensions and closed to modifications.
The origin of the problem:
During the software life cycle, when the original code of the software needs to be modified due to changes, upgrades, and maintenance, it may introduce errors into the old code, or it may cause us to refactor the entire function. There is code that has been retested.
Solution:
When software needs to change, try to implement changes by extending the behavior of the software entities, rather than modifying the existing code to implement the changes.
To sum up:
Use the abstract build framework to extend the details with implementation. Because the abstract flexibility is good and the adaptability is wide, as long as the abstraction is reasonable, the software architecture can be basically kept stable. And the variable details in the software, we use the abstraction-derived implementation class to expand, when the software needs to change, we only need to re-derive an implementation class to expand according to the requirements. Of course, the premise is that our abstraction should be reasonable, and we must be forward-looking and predictive of changes in demand.


