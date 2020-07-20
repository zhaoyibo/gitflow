#!/bin/sh
# sh -c "$(curl -fsSL http://gitflow.wb-intra.com/gitflow-installer.sh)" && source .zshrc

DOMAIN="https://raw.githubusercontent.com/zhaoyibo/gitflow/master"
ENV_FILE=""
IS_ZSH=0

if [[ -n $(env | grep "SHELL" | grep "zsh") ]]; then
  echo "using zsh"
  ENV_FILE="$HOME/.zshrc"
  IS_ZSH=1
else
  echo "using bash"
  ENV_FILE=$HOME/.bash_profile
fi

GITFLOW_HOME=$HOME/.gitflow

if [ ! -p $GITFLOW_HOME/bin ]; then
  mkdir -p $GITFLOW_HOME/bin
fi

curl -s -o $GITFLOW_HOME/bin/gitflow $DOMAIN/gitflow
chmod +x $GITFLOW_HOME/bin/gitflow
curl -s -o $GITFLOW_HOME/version $DOMAIN/version

if [ -z "$(grep "export PATH=\$PATH:$HOME/.gitflow/bin" $ENV_FILE)" ]; then
  echo "\nexport PATH=\$PATH:$HOME/.gitflow/bin" >>$ENV_FILE
  echo "\nalias gf=gitflow" >>$ENV_FILE
fi

if [[ $IS_ZSH == 1 ]]; then
  if [ ! -p $GITFLOW_HOME/completion ]; then
    mkdir -p $GITFLOW_HOME/completion
  fi
  curl -s -o $GITFLOW_HOME/completion/_gitflow $DOMAIN/_gitflow
  if [ -z "$(grep "fpath=($HOME/.gitflow/completion \$fpath)" $ENV_FILE)" ]; then
    echo "\nfpath=($HOME/.gitflow/completion \$fpath)" >>$ENV_FILE
  fi
  if [ -z "$(grep "autoload -Uz compinit && compinit -i" $ENV_FILE)" ]; then
    echo "\nautoload -Uz compinit && compinit -i" >>$ENV_FILE
  fi
fi

echo
echo "请根据您的使用习惯配置 gitflow 在 merge 后的行为"
echo "\033[31m 注意 \033[0m"
echo "\033[31m  - 以下配置项均不会影响往 master 分支的合并 \033[0m"
echo "\033[31m  - 安装结束后可以通过 gf config 命令重新配置 \033[0m"
echo
echo "merge 后是否自动 push 到远端："
echo "  1. 自动 push"
echo "  2. 手动 push"
printf "请选择："
read merge_auto_push
while [[ True ]]; do
  case $merge_auto_push in
  1)
    merge_auto_push="true"
    break
    ;;
  2)
    merge_auto_push="false"
    break
    ;;
  *)
    printf "输入有误，请重新输入："
    read merge_auto_push
    ;;
  esac
done

echo
echo "merge 后切到哪个分支："
echo "  1. <from> 分支（例如将 feature/demo 合并到 develop，最后会回到 feature/demo 分支。一般选择「自动 push」时使用该项）"
echo "  2. <to> 分支（例如将 feature/demo 合并到 develop，最后会停留在 develop 分支。一般选择「手动 push」时使用该项）"
echo "  3. 执行 gitflow 命令时所在的分支（例如在 test 分支执行命令将 feature/demo 合并到 develop，最后会回到 test 分支。）"
printf "请选择："
read merge_stay_branch
while [[ True ]]; do
  case $merge_stay_branch in
  1)
    merge_stay_branch="from"
    break
    ;;
  2)
    merge_stay_branch="to"
    break
    ;;
  3)
    merge_stay_branch="current"
    break
    ;;
  *)
    printf "输入有误，请重新输入："
    read merge_stay_branch
    ;;
  esac
done

echo
echo "merge 无冲突时是否自动保存 commit（即自动保存并退出 vim）："
echo "  1. 自动保存"
echo "  2. 手动保存"
printf "请选择："
read merge_auto_commit
while [[ True ]]; do
  case $merge_auto_commit in
  1)
    merge_auto_commit="true"
    break
    ;;
  2)
    merge_auto_commit="false"
    break
    ;;
  *)
    printf "输入有误，请重新输入："
    read merge_auto_commit
    ;;
  esac
done

cat <<EOF >$GITFLOW_HOME/config
merge_auto_push=$merge_auto_push
merge_stay_branch=$merge_stay_branch
merge_auto_commit=$merge_auto_commit
EOF

echo
echo "gitflow 安装完成"
# source $ENV_FILE
