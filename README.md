# Actions功能自动编译OpenWRT固件

## 简介
 **此仓库使用github的Actions功能自动编译OpenWRT固件，且自动对编译脚本进行列表更新 (前提是已经[创建仓库环境变量](#创建仓库环境变量) ）**
 
 **更新功能如下（手动更新/每天定时自动更新）**
 
 **1.更新指定仓库工作流脚本里的分支列表**
 
 **2.更新工作流脚本里路由资源列表(编译方案)**
 
## 如需二次发布请注明我的 GitHub 仓库链接:(https://github.com/nixevol/OpenWrt-ActionsBuild) 谢谢合作！

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
- [关于 UpdateActionsData.sh 脚本](#关于UpdateActionsData.sh脚本)

## 详细内容

### 创建路由资源目录
1.在仓库的主目录下创建一个文件夹(建议使用路由型号命名，以便于区分)

2.把需要的文件和脚本放置到文件夹内，具体参考 - [路由资源目录各文件作用](#路由资源目录各文件作用)

  注意:
  
       其中的 .config 文件为必须文件，请自行配置并上传，
  
       其他文件如过无需替换或执行，可不上传或者在执行Actions时将对应的选项选择为 false
       
 **注意！！：新建资源目录后需要在Actions中执行 手动更新Actions ，否则无法在 固件编译 时选择此资源目录**
 
### 路由资源目录各文件作用

**路由资源目录内存放指定路由的配置方案，其配置文件说明如下**

**-   Actions中执行 手动更新Actions 等操作需要先[创建仓库环境变量](#创建仓库环境变量) **

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

 **针对自定义脚本则需要自行输入OpenWRT源仓库链接与分支名称**

 4.**点击![image](https://user-images.githubusercontent.com/35430449/152686504-069f766c-b7b5-4c4c-a3f8-ca00f4c3997c.png)即可自动编译**

 编译完成后可在任务内查看或下载结果，如需发布到release，请在配置参数是将 发布到release 设置为 true ![image](https://user-images.githubusercontent.com/35430449/152686705-554634b2-9484-4985-88b7-9d53994e716c.png)
 并配置[GIT_TOKEN](#GIT_TOKEN)

 注意，发布release必须配置[GIT_TOKEN](#GIT_TOKEN)，否则无法发布


### 创建仓库环境变量

**项目中按照 Setting--Secrets--New repository 添加仓库变量**

**仓库变量一共三个，分别为 [GIT_TOKEN](#GIT_TOKEN) , [GIT_UNAME](#GIT_UNAME) , [GIT_UEMAIL](#GIT_UEMAIL)**

![image](https://user-images.githubusercontent.com/35430449/152686939-f1275364-a61d-41ab-a9ad-ed38740c999d.png)



### GIT_TOKEN

**此变量需要在帐号设置中新建**

**步骤：点击用户头像->Settings->Developer settings->Personal access tokens->Generate new token **
![image](https://user-images.githubusercontent.com/35430449/152687345-71e35f24-82af-4ed6-9fa7-752db5d5881a.png)

![image](https://user-images.githubusercontent.com/35430449/152687386-0119ff60-fd78-40db-afb9-ddc75758ef8e.png)

**注意：Token的过期时间建议设置为无限期，权限需要三个，分别为 repo workflows user  如图所示**

![image](https://user-images.githubusercontent.com/35430449/152687557-bb67794c-fc94-475e-8ed9-83b1843de0af.png)


**然后点击**![image](https://user-images.githubusercontent.com/35430449/152687624-4f1def65-d4af-4fdc-9386-915c24281cb8.png)

**将创建后的Token复制到仓库变量中的 GIT_TOKEN 里面并保存**
![image](https://user-images.githubusercontent.com/35430449/152687712-f93ab33d-88b6-4c72-a85d-b412940b7bf7.png)

![image](https://user-images.githubusercontent.com/35430449/152687766-552db652-7a6e-4790-a74f-b7f9c9ba93a1.png)

### GIT_UNAME

**此变量为您的GITHUB帐号名称，可在点击头像后查看**

 例如:

 ![image](https://user-images.githubusercontent.com/35430449/152687976-d2f5a53a-91c9-4731-8532-2d5bd225cc7a.png)


### GIT_UEMAIL

**此变量为您GITHUB帐号的注册邮箱**

 **[点击此处查看](https://github.com/settings/emails)**

 ![image](https://user-images.githubusercontent.com/35430449/152688142-6bdd4b7f-dd63-47de-94ef-e1fe3ef20702.png)



### 创建可更新的yml脚本

 1. 进入.github/workflows目录下新建一个yml脚本，并从其他buildOpenWRT_xxx.yml 中复制代码进去
  （注意：请不要使用 **buildOpenWRT_custom.yml** 的代码）

 2. 将新建脚本内的 REPO_URL: 值更换为您需要自动更新分支列表的仓库链接，保存文件后再从 **Actions** 内执行 **手动更新Actions** 操作

  例如：REPO_URL: https://github.com/coolsnowwolf/lede

 ![image](https://user-images.githubusercontent.com/35430449/152689320-83ca9cf0-4c30-4404-8fb9-271117dd41b3.png)


### 更改自动更新时间
 **仓库默认每天凌晨0点(北京时间)自动更新**
 
 编辑.github/workflows目录下的 **update_auto.yml** 文件
 
 修改 
 
       - cron: '0 16 * * *'
       
 这一段代码即可

![image](https://user-images.githubusercontent.com/35430449/152690539-0f5a98b3-f791-4ae8-bde5-84532c36829f.png)

### 关于UpdateActionsData.sh脚本

  **此脚本为更新yml文件的脚本代码，如果没有特殊需要，一般无需修改**



## 捐赠

**如果你觉得此项目对你有帮助，可以捐助我们，以鼓励项目能持续发展，更加完善**

微信：

![image](https://user-images.githubusercontent.com/35430449/152690757-9e680080-07a6-41fd-9d5a-302652811b1d.png)

支付宝：

![image](https://user-images.githubusercontent.com/35430449/152690751-6e06c20a-5ac5-4736-a7e0-d3b13258b316.png)
