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
- [关于 UpdateActionsData.sh 脚本]

### [捐赠](#捐赠)
