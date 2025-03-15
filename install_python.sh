#!/bin/bash

echo '开始安装 Python'

# 定义版本列表
versions=(
  "3.6.15"
  "3.7.17"
  "3.8.18"
  "3.9.18"
  "3.10.13"
  "3.11.8"
  "3.12.4"
  "3.13.0a4"
)

# 显示版本选择菜单
echo "请选择 Python 版本："
for i in "${!versions[@]}"; do
  printf "%d. %s\n" "$((i+1))" "${versions[$i]}"
done

# 获取用户输入
read -p "请输入数字（默认 3.12.4）：" choice

# 设置默认版本
if [ -z "$choice" ]; then
  choice=$(( ${#versions[@]} ))
fi

# 验证用户输入
if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#versions[@]}" ]; then
  echo "无效的输入，将使用默认版本 3.12.4"
  choice=$(( ${#versions[@]} ))
fi

# 设置 Python 版本变量
PYTHON_VERSION=${versions[$((choice-1))]}
echo "您选择的版本是：$PYTHON_VERSION"

# 检查是否为 root 用户
if [ "$(id -u)" = "0" ]; then
  echo '检测到 root 用户'

  # 更新软件包列表
  sudo apt update
  echo '正在更新软件包列表...'

  # 安装依赖项
  sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
  echo '正在安装依赖项...'

  # 下载Python源代码
  wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
  echo "正在下载 Python $PYTHON_VERSION 源代码..."

  # 解压缩
  tar -xzf Python-$PYTHON_VERSION.tgz

  # 进入Python源代码目录
  cd Python-$PYTHON_VERSION
  echo '正在解压缩源代码...'

  # 配置
  ./configure --enable-optimizations
  echo '正在配置 Python...'

  # 编译
  make -j $(nproc)
  echo '正在编译 Python...'

  # 安装
  sudo make altinstall
  echo '正在安装 Python...'

  # 安装pip
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python${PYTHON_VERSION//./} get-pip.py
  echo '正在安装 pip...'
  echo "Python $PYTHON_VERSION 安装完成 (root 用户)！"

else
  echo '检测到非 root 用户'

  # 更新软件包列表
  sudo apt update
  echo '正在更新软件包列表...'

  # 安装依赖项
  sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
  echo '正在安装依赖项...'

  # 下载Python源代码
  wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
  echo "正在下载 Python $PYTHON_VERSION 源代码..."

  # 解压缩
  tar -xzf Python-$PYTHON_VERSION.tgz

  # 进入Python源代码目录
  cd Python-$PYTHON_VERSION
  echo '正在解压缩源代码...'

  # 配置
  ./configure --enable-optimizations
  echo '正在配置 Python...'

  # 编译
  make -j $(nproc)
  echo '正在编译 Python...'

  # 安装
  make install
  echo '正在安装 Python...'

  # 安装pip
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python${PYTHON_VERSION//./} get-pip.py
  echo '正在安装 pip...'
  echo "Python $PYTHON_VERSION 安装完成 (非 root 用户)！"
fi