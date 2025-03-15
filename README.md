# install_python.sh 脚本说明

## 简介

`install_python.sh` 是一个 Bash 脚本，用于在 Linux 系统上一键安装 Python 3。该脚本支持多个 Python 版本，并允许用户在安装前选择所需的版本。

## 支持的系统

该脚本目前主要针对基于 Debian 的 Linux 发行版（如 Ubuntu）进行测试和开发。

## 使用方法

1.  **下载脚本**：

    您可以使用 `wget` 命令下载脚本：

    ```bash
    wget <脚本的URL>
    ```
    请将 `<脚本的URL>` 替换为脚本的实际 URL。

2.  **赋予执行权限**：

    下载完成后，您需要为脚本赋予执行权限：

    ```bash
    chmod +x install_python.sh
    ```


## 版本选择

脚本在运行时会显示一个 Python 版本选择菜单。您可以输入对应版本的数字来选择要安装的版本。如果直接按 Enter 键，脚本将安装默认版本（目前为 3.12.4）。

```
请选择 Python 版本：
1. 3.6.15
2. 3.7.17
3. 3.8.18
4. 3.9.18
5. 3.10.13
6. 3.11.8
7. 3.12.4
8. 3.13.0a4
请输入数字（默认 3.12.4）：
```

## Root 用户和非 Root 用户

脚本会自动检测当前用户是否为 root 用户。

-   如果是 root 用户，脚本将使用 `sudo` 命令安装软件包和 Python，并使用 `make altinstall` 安装 Python，以避免与系统自带的 Python 版本冲突。
-   如果不是 root 用户，脚本会尝试使用 `sudo` 命令安装软件包和 Python。如果当前用户没有 `sudo` 权限，安装可能会失败。在这种情况下，您可能需要手动安装所需的依赖项。脚本会使用`make install`安装python。

## 依赖项

脚本会自动安装以下依赖项：

-   `build-essential`
-   `zlib1g-dev`
-   `libncurses5-dev`
-   `libgdbm-dev`
-   `libnss3-dev`
-   `libssl-dev`
-   `libreadline-dev`
-   `libffi-dev`
-   `libsqlite3-dev`
-   `wget`
-   `libbz2-dev`

## 注意事项

-   在运行脚本之前，请确保您的系统满足脚本的依赖项要求。
-   如果您不确定要选择哪个 Python 版本，建议使用默认版本。
-   如果您在安装过程中遇到任何问题，请检查您的网络连接和系统配置。


作者：Hank-Chromela(Gemini 2.0 Pro)
