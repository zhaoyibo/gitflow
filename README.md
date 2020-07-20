[TOC]

# Gitflow 使用说明



## 安装 gitlfow


### 安装

**先抬头看下 iTerm2 上方这括号里是啥**

![pic](https://cdn.jsdelivr.net/gh/zhaoyibo/resource@gh-pages/img/1595239024278.jpg)

**如果终端安装的是 zsh：**

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zhaoyibo/spring-cloud-study/master/gitflow-installer.sh)" && source $HOME/.zshrc
```

**如果是自带的 bash：（bash 不支持自动补全）**

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zhaoyibo/spring-cloud-study/master/gitflow-installer.sh)" && source $HOME/.bash_profile
```

配置使用习惯

```
请根据您的使用习惯配置 gitflow 在 merge 后的行为
 注意
  - 以下配置项均不会影响往 master 分支的合并
  - 安装结束后可以通过 gf config 命令重新配置
 
merge 后是否自动 push 到远端：
  1. 自动 push
  2. 手动 push
请选择：1
 
merge 后切到哪个分支：
  1. <from> 分支（例如 feature 下的分支、hotfix 下的分支，一般选择「自动 push」时使用该项）
  2. <to> 分支（例如 develop、test 分支，一般选择「手动 push」时使用该项）
  3. 执行 gitflow 命令时所在的分支（尽量不要选该项，除非你明确知道其使用场景）
请选择：1
 
merge 无冲突时是否自动保存 commit（即自动保存并退出 vim）：
  1. 自动保存
  2. 手动保存
请选择：1
 
gitflow 安装完成
```

之后输入 `gf` 如果出现以下内容就说明安装成功了

```
usage: gitflow <subcommand>
 
【子命令】
   (f)eature             管理功能分支（gf f help 查看详情）
   (h)otfix              管理修复分支（gf h help 查看详情）
 
【这部分命令与 git 原生命令相同】
   status
   checkout <branch>              简写 co
   add <files...>
   commit [[-a] -m <message>]     简写 cm
   push [--set-upstream origin <branch>]
 
【tag 相关】
   tag <name> <message>  打 tag
   taglist               查看已有 tag 
 
【gitflow 相关】
   config                配置 gitflow
   version               查看当前 gitflow 版本
```

### 更新

同安装

### 美化 diff 命令

安装 icdiff 即可

```
`brew install icdiff`
```

## 分支约定

### 固定分支

1. **开发分支 develop** - 用于发布到 dev 环境，上游分支为 feature 和 hotfix
2. **开发分支 test** - 用于发布到 test 环境，上游分支为 feature 和 hotfix
3. **正式分支 master** - 用于发布到正式环境，上游分支为 feature 和 hotfix

### 临时分支

1. 功能分支 feature - 用于新功能的开发，分支名以 feature/ 为前缀
2. 修复分支 hotfix - 用于 bug 的修复，分支名以 hotfix/ 为前缀

说明：使用下边的 gitflow 工具的时候，创建的分支会自动带上以上前缀，比如 gitflow feature start yibo-push 会创建出一个名为 feature/yibo-push 分支，之后再使用 gitflow feature 命令的时候就不需要再写 feature/ 前缀了。

建议：每个同学的分支名上都带上自己的名字缩写，以便于区分。

### 分支规范

1. 不能在 `develop`、`test`、`master` 分支直接修改代码
2. 不能将 `feature` 分支、hot`fix` 分支直接越过 `test` 分支（即不经过测试）合并到 `master` 分支
3. 不能将 `test`、`develop` 分支的代码合并到 `feature` 或 `hotfix` 分支

## 使用

### 命令速查

![pic](https://cdn.jsdelivr.net/gh/zhaoyibo/resource@gh-pages/img/1595239001273.jpg)

### 主命令说明

#### `gitflow`（简写：`gf`）

输出如下：

```
usage: gitflow <subcommand>
 
【子命令】
   (f)eature             管理功能分支（gf f help 查看详情）
   (h)otfix              管理修复分支（gf h help 查看详情）
 
【这部分命令与 git 原生命令相同】
   status
   checkout <branch>              简写 co
   add <files...>
   commit [[-a] -m <message>]     简写 cm
   push [--set-upstream origin <branch>]
 
【tag 相关】
   tag <name> <message>  打 tag
   taglist               查看已有 tag 列表
 
【gitflow 相关】
   config                配置 gitflow
   version               查看当前 gitflow 版本
```

### 子命令说明



#### `gitflow add <files...>`

把文件添加到暂存区，例如 `gitflow add .`



#### `gitflow commit [[-a] -m message]`（简写：`gf cm`）

提交一个 commit，例如 `gitflow commit -m "修复 xxxx 问题"`



#### `gitflow push`

把提交推送到远端仓库



#### `gitflow tag <name> <message>`

打 tag，例如 `gitflow tag "v1.0" "xxxx release"`



#### `gitflow feature`（简写：`gf f`）

功能分支的创建、删除、合并、PR 等操作。

```
$ gitflow feature help
usage: gitflow feature start <name> [<base>]            开始一个名为 feature/<name> 的新分支
       gitflow feature mergeto <to>                     将当前分支 merge 到 <to> 分支里，命令简写 mt
       gitflow feature merge <from> <to>                将 feature/<from> 分支 merge 到 <to> 分支里，命令简写 m
       gitflow feature diff <develop|test|master>       将当前分支与固定分支做 diff
       gitflow feature checkout [<name>]                切到 feature/<name> 分支，命令简写 co
       gitflow feature (del)ete [-r] <name>             删除本地或远程(-r)的 feature/<name> 分支，命令简写 del
       gitflow feature sync [<base>]                    将 <base> 的最新代码合并到当前分支，<base> 默认为 master
```



##### `gitflow feature list`（简写：`gf f`）

列出所有的功能分支（即以 `feature/` 开头的分支）



##### `gitflow feature start <name> [<base>]`

简写：`gf f start <name>`

开始一个功能分支，分支名会自动带 `feature/` 前缀，无需手动添加。**默认会从最新的 `master` 分支检出**，可以添加 `<base>` 参数以从指定的分支检出。

例如：`gitflow feature start demo master` 会从 `master` 分支检出一个名为 `feature/demo` 的功能分支，并会自动切换到该分支。

需要注意的是，之后再使用 `gitflow feature` 命令的时候，分支名 `feature/demo` 并不需要打全称，而是直接用 `demo`。

做了什么： （以下 `<base>` 默认均指 `master`）

- 不允许从 `develop` 和 `test` 分支检出代码
- 检查当前工作区与索引是否 “干净”
- 检查远端是否存在 `<base>` 分支
- 切到 `<base>` 分支并 pull
- 从 `<base>` 检出分支



##### `gitflow feature mergeto <to>`（简写：`gf f mergeto <to>`）

将当前所在的功能分支合并到别的分支

做了什么：

- 检查当前分支是不是 `feature` 分支，不是的话会直接退出
- 获取当前分支名，然后内部调用下边的 `gitflow feature merge 当前分支 <to>`



##### `gitflow feature merge <from> <to>`（简写：`gf f merge <from> <to>`）

将功能分支 from 合并到其他分支 to。

例如将上文中 `feature/demo` 合并进 `test`，命令为 `gitflow feature merge demo test`。

如果 merge 操作遇到冲突，会有相关的提示。如果你对 `<to>` 分支无 push 权限，那么 merge 操作并不会被执行，转而提示进行 pull request 操作。

**merge 与 mergeto 的区别、使用场景：** 执行 mergeto 命令必须当期处于 `feature/` 或 `hotfix/` 分支上，否则会报错。merge 命令不需要在指定分支上，比如我当前在 `develop` 分支上，我想把 `feature/demo` 合并到的 `test` 分支上，那么我并不需要先切到 `test` 分支或 `feature/demo` 分支上再操作，直接在 `develop` 上执行 `gf f merge demo test` 就行了。（merge 命令 `<to>` 可以是任何分支，如果两个功能分支要进行合并，那么 `<to>` 要写分支全名，`<from>` 是短名，比如 `gf f merge yibo-1 feature/yibo-2`）

做了什么：

- 检查 `feature/<from>` 分支是否存在
- 如果 `<to>` 是 `master` 分支，检查你是否有权限向 `master` 进行 push 操作
- 检查 `<to>` 分支是否存在（包括本地和远端）
- 要求本地工作区是干净的
- 会先从远端分别 pull 一遍 `<from>` 和 `<to>`
- 要求本地分支 `<from>` 分支和远端的 `origin/<from>` 分支完全一致
- 再对 `<to>` 分支 “暴力” 的 pull 一遍
- 根据 `<to>` 分支
- 如果不是 `master` 分支，用 `merge --no-ff` 进行合并，并自动 push（不使用 fast-forward 方式合并，保留源分支的 commit 历史）
- 如果是 `master` 分支，用 `merge --squash` 进行合并（需要手动提交并 push）（使用 squash 方式合并，把多次分支 commit 历史压缩为一次）

![pic](https://cdn.jsdelivr.net/gh/zhaoyibo/resource@gh-pages/img/1595238981713.jpg)



##### `gitflow feature diff <other>`简写：`gf f diff <other>`

和 `<other>` 分支进行 diff 操作。



##### `gitflow feature checkout <name>`（简写：`gf f co <name>`）

检出指定的功能分支，例如` gitflow feature checkout demo`，则会检出上文中创建的 `feature/demo` 分支。



##### `gitflow feature delete <name>`（简写：`gf f del <name>`）

删除指定的功能分支，例如 `gitflow feature delete demo`。

每次代码合并进 `master` 或者 PR 被接受后，都应该删除该功能分支。

注意，不能删除当前所在分支。



##### `gitflow feature sync [<base>]`

简化命令：`gf f sync`

将 `<base>` 的最新代码合并到当前分支，`<base>` 默认为 `master`。



#### `gitflow hotfix（简写：gf h）`

修复分支的创建、删除、合并、PR 等操作。

命令同 feature，不再一一列举。

