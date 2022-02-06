# 使用github的Actions功能自动编译OpenWRT固件

## 仓库说明
### 1.多脚本自定义编译
- [创建路由资源目录](#创建路由资源目录)
- [路由资源目录各文件作用](#路由资源目录各文件作用)
- [如何编译OpenWRT固件](#如何编译OpenWRT固件)

### 2.配置 自动/手动 更新Actions功能(.github/workflows/内的yml脚本)
- [创建仓库环境变量(必要)](#创建仓库环境变量)
- - [GIT_TOKEN](#GIT_TOKEN)
- - [GIT_UNAME](#GIT_UNAME)
- - [GIT_UEMAIL](#GIT_UEMAIL)
- [创建可更新的yml脚本](#创建可更新的yml脚本)
- [更改自动更新时间](#更改自动更新时间)
- [关于 UpdateActionsData.sh 脚本](#关于 UpdateActionsData.sh 脚本)

## 详细内容

### 创建路由资源目录
1.在仓库的主目录下创建一个文件夹(建议使用路由型号命名，以便于区分)

2.把需要的文件和脚本放置到文件夹内，具体参考 - [路由资源目录各文件作用](#路由资源目录各文件作用)

  注意:
  
       其中的 .config 文件为必须文件，请自行配置并上传，
  
       其他文件如过无需替换或执行，可不上传或者在执行Actions时将对应的选项选择为 false
  
### 路由资源目录各文件作用

**路由资源目录内存放指定路由的配置方案，其配置文件说明如下**

1. **.config**(必须) 
  
  此文件为定制路由及其插件的配置文件，必须存在路由资源目录内，可修改不同名称，但必须在Actions执行编译时一并修改。
   
   例如：.config文件名为 openwrt.config ,则Actions编译时 config 文件名称 项 亦需要修改
   
   ![image](https://user-images.githubusercontent.com/35430449/152682115-ded3d6d2-f08c-4f82-aefc-e320d191a0dd.png)


2. **feeds.conf.default**(非必要)

  此文件为自定义软件源文件，具体功能请自行搜索，此文件非必要，可以不上传或在执行Actions时将对应的选项选择为 false，编译时将使用openwrt源代码内的feeds.conf.default作为软件源
  
  

3. **files**(目录)(非必要)

  此目录具体作用可以参考[https://blog.csdn.net/x13163303344/article/details/117174381](https://blog.csdn.net/x13163303344/article/details/117174381)
  
  此目录非必要，可以不上传或在执行Actions时将对应的选项选择为 false
  

4. **openwrt_patch.sh**(非必要)

  此脚本将会在 拉取 OpenWRT仓库源代码后
  
  以及执行
  
       ./scripts/feeds update -a && ./scripts/feeds install -a
       
   之前 执行，可用作对OpenWRT仓库自带的feeds.conf.default 进行修改、添加 或者 执行其他的命令，或有其他命令请自行决定
   
   非必要脚本，可以不上传或在执行Actions时将对应的选项选择为 false
   
   
5.**make_befor.sh**(非必要)

  此脚本将会在执行
  
      ./scripts/feeds update -a && ./scripts/feeds install -a
  之后 执行，其他作用请自行决定，
  
  非必要脚本，可以不上传或在执行Actions时将对应的选项选择为 false
  
6.**make_after.sh**(非必要)

  此脚本将会在 编译固件完成之后 执行，其他作用请自行决定，
  
  非必要脚本，可以不上传或在执行Actions时将对应的选项选择为 false
  
  
### 如何编译OpenWRT固件

1.**点击拉取后仓库上方的Actions按钮**

![image](https://user-images.githubusercontent.com/35430449/152683646-f7b9a05d-9faf-41ef-98d0-2e934984a8ba.png)

2.**选择需要编译的源码来源或者自定义源码来源**

![image](https://user-images.githubusercontent.com/35430449/152683856-75512be0-02da-465a-9aba-9d56e9ff5b68.png)

3.**点击 Run workflows 按钮并配置参数**

![image](https://user-images.githubusercontent.com/35430449/152686091-001fb586-8f92-4cfa-914f-82984bf6cfed.png)

**指定OpenWRT源仓库的脚本可以下拉选择拉取的分支，分支列表在 [创建仓库环境变量](#创建仓库环境变量) 后将会每天自动更新或者自行进行手动更新后更新列表**
![image](https://user-images.githubusercontent.com/35430449/152686363-59ee75eb-35d4-4662-87a0-600b9cb502e4.png)
