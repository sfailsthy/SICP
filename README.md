# SICP
Structure and Interpretation of Computer Programs


&emsp;&emsp;![计算机程序的构造和解释 第二版][1]
# TODO
- charpter 2
  - exercise 2.14
  - exercise 2.15
  - exercise 2.16
  - exercise 2.43
  - exercise 2.74
  - exercise 2.90
  - exercise 2.92

- charpter 3
  - 3.3.1 Mutable List Structure
  - exercise 3.16
  - exercise 3.17
  - exercise 3.18
  - exercise 3.19
  - exercise 3.25
  - exercise 3.26
  - 3.4 Concurrency: Time is of the Essence

- charpter 4
  - exercise 4.5
  - exercise 4.11
  - exercise 4.12
  - exercise 4.13
  - 4.1.6 Internal Definitions
  - exercise 4.31
  - exercise 4.34
  - 4.3.2 Parsing Natural Language
  - exercise 4.63
  - exercise 4.67
  - exercise 4.69
  - exercise 4.79

- charpter 5
  - exercise 5.10
  - exercise 5.11
  - exercise 5.12
  - exercise 5.13
  - exercise 5.17
  - exercise 5.19
  - exercise 5.24
  - exercise 5.25
  - exercise 5.30
  - 5.5 Compilation

  
# Reference
- [SICP解题集](http://sicp.readthedocs.io/en/latest/)
- [sicp-solutions](http://community.schemewiki.org/?sicp-solutions)
- [Eli Bendersky's website](https://eli.thegreenplace.net/tag/sicp)
- [collins562/SICP-solutions](https://github.com/collins562/SICP-solutions)
- [SICP exercises](https://wizardbook.wordpress.com)


**读书笔记**
&emsp;&emsp;目前这本书大致完成情况：除了3.4并发和5.5的编译以及极个别小节外，基本完成了整本书的学习，书中的习题也仅剩不到二十个。从github上的commit log看，花了不到二十天完成，算是很快了。如果让我对这本书评价，只想说这是我从大学开始学编程以来读过最好的书籍。(看过的书，除了数据结构、Java等语言、计算机组成原理等学校开设的课程外，只有机器学习相关的几本书，再加上《深入理解计算机系统》(这本书也学到了很多，但是感觉没有SICP更震撼。)

简单回顾与总结：

 **1. 第一章：构造过程抽象**
 - Miller-Rabin素性检测算法
 - 序列求和的抽象模式
      &emsp;&emsp;书中举了几个例子：计算给定范围内的正整数之和、给定范围内的正整数的立方之和、π值、定积分，再加上习题里的乘积，进一步抽象为累积(这应该是为第二章的2.23小节:序列作为一种约定的界面做铺垫)。
 - 利用平均阻尼计算n次方根
&emsp;&emsp;总体来说，第一章相对较简单，算是讲了编程的一些基础知识吧，有编程经验的人应该很容易。至于1.3节的高阶函数，我学过Python因此对map、lambda、过程(函数)作为参数、过程作为返回值很熟悉，没什么障碍。

 **2. 第二章：构造数据抽象**
    &emsp;&emsp;从这一章开始，真正从这本书中学到了很多。正如标题所言：数据抽象，之前只知道抽象抽象，以为自己很懂抽象，学了这一章才真正对抽象有了初步认识。
 - 数据是什么
    >&emsp;&emsp;一般而言，我们总可以将数据定义为一组适当的选择函数和构造函数，以及为使这些过程成为一套合法表示，它们就必须满足的一组特定条件
 - 序列作为一种约定的界面
    &emsp;&emsp;书中讲了好多例子:枚举区间、枚举树的所有叶子、求给定范围内斐波那契数列之和、枚举序对，加上习题中的求多项式值、矩阵相关数学运算，最后以习题中的八皇后问题结束这一小节。
 - 一个图形语言
    &emsp;&emsp;这一节说实话并没学到什么，主要是目前没找到相关的函数包运行书中的代码。(待更)
 - 符号求导
    &emsp;&emsp;这算是整本书第一个利用数据抽象的思想构建的第一个“大型系统”。
 - 消息传递
      &emsp;&emsp;应该就是面向对象思想中的用对象调用函数，加上第三章的局部状态(可以看作面向对象思想中的成员变量)，可以看做“构造一个面向对象语言”了。
 - 利用数据导向构建通用型操作的系统
      &emsp;&emsp;思想简单来说就是利用数据抽象的思想，分别实现各种数据类型选择函数和构造函数，然后针对每种数据类型实现外层接口和底层实现。
 - 最后一节的习题：简化有理分式的数学相关知识

**3.第三章：模块化、对象和状态**
 - 赋值的代价
 - 求值的环境模型
   &emsp;&emsp;这里有更详细的讲解[SICP 中环境模型可以等价为龙书中 (第七章) 讲的的运行时刻环境么？](https://www.zhihu.com/question/27307480/answer/36104254)
 - 表格的表示
 &emsp;&emsp;我的理解是实现了一种映射(C++语言中的map等)
 - 数字电路模拟、约束系统
   &emsp;&emsp;这两小节学的时候听震撼的，尤其是书中提到的“用计算机时间去模拟现实时间”。然而现在只知道大致印象，具体的细节已经忘了好多。
 - 并发
 &emsp;&emsp;书中讲了许多操作系统相关的知识，就暂时跳过了，待更。
 - 流
   &emsp;&emsp;学会了延时求值，这里有更详细的讨论[sicp 中的流模式在实际开发中有什么应用？](https://www.zhihu.com/question/31423936)在做这一节的习题解决一系列数学问题时感觉很震撼。
**4.第四章：元语言抽象**
&emsp;&emsp;这章和第五章，我认为就是在讲编译原理。
 - 元循环求值器
 &emsp;&emsp;这一小节算是用scheme语言实现了scheme语言的解释器。学到了计算机语言的本质:eval-apply循环(这个思想在后面的多个解释器中都用到了)。构建大型系统的方法也是第二章提到的数据抽象、数据类型分派。
 - 惰性求值
&emsp;&emsp;在第一节的基础上做了些改动。基本思想没什么变化。
 - 非确定型计算
 &emsp;&emsp;可以理解为搜索的具体应用，书中还用到了回溯，这是搜索中最基本的思想。对书中实现amb求值器的代码暂时有几处没怎么搞懂。
 - 逻辑程序设计
 &emsp;&emsp;算是实现了语言Prolog的简单功能。
**5.第五章：寄存器里的计算**
&emsp;&emsp;这章和第四章一样，在讲基本的编译原理。书中用的描述寄存器机器的语言，可以看做是一种汇编语言。
 - 寄存器机器模拟器
 &emsp;&emsp;用scheme语言(高级语言)实现了一种汇编语言(低级语言)的模拟器，看懂书中的例子、解决习题需要对这种语言有一定熟悉，最难的应该是入栈、出栈以保存和恢复相关寄存器。(第4小节的也是)
 - 存储分配和垃圾回收
 书中没有具体实现，只大概讲了算法，对这一小节理解不深。
 - 显示控制的求值器
&emsp;&emsp;这一小节相当于用一种汇编语言(低级语言)实现了scheme(高级语言)的模拟器，然后在第2小节的寄存器机器模拟器上运行。

[1]: https://img3.doubanio.com/lpic/s1113106.jpg