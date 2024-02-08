<div align="center">
<h1>基于XMake构建的STM32-RT-thread-nano项目</h1>
</div>

## 为什么选择Xmake构建？
XMake 轻量，语法简单，构建快速。配合VScode XMake插件能够快速搭建基于VScode的嵌入式开发环境。

## 确保安装了构建系统XMake以及ARM工具链
- XMake
- arm-none-eabi-gcc
- OpenOCD

### 移植流程
- 使用STM32CubeMx创建Makefile工程
- 添加rt-thread项目源码,根据文档编写移植代码,添加构建参数
- 修改启动文件(startup_stm32f103xe.s)用于移植RT-Thread-nano
``` 
//修改前：
  bl  SystemInit
  bl  main

//修改后：
  bl  SystemInit
  bl  entry            /* 修改此处，由 main 改为 entry */
```
- 移植rt-thread finsh组件,根据官网文档移植
- 修改链接脚本让finsh正常使用(在.text块中添加如下代码)
```
/* section information for finsh shell */
    . = ALIGN(4);
    __fsymtab_start = .;
    KEEP(*(FSymTab))
    __fsymtab_end = .;
    
    . = ALIGN(4);
    __vsymtab_start = .;
    KEEP(*(VSymTab))
    __vsymtab_end = .;

    . = ALIGN(4);
    /* section information for initial. */
    . = ALIGN(4);
    __rt_init_start = .;
    KEEP(*(SORT(.rti_fn*)))
    __rt_init_end = .;
    . = ALIGN(4);
```
- 终端运行 xmake