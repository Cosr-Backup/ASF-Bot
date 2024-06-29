ARG PORT=1242
FROM justarchi/archisteamfarm:latest

# 设置工作目录
WORKDIR /

# 安装必要的软件包，包括创建虚拟环境所需的python3-venv
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv

# 克隆代码仓库
RUN git clone https://github.com/zhongfly/telegram-bot-asf.git --depth=1

# 切换到克隆的代码目录
WORKDIR /telegram-bot-asf

# 创建并激活虚拟环境，安装依赖包
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install -r requirements.txt

# 设置环境变量以使用虚拟环境中的Python和pip
ENV PATH="/telegram-bot-asf/venv/bin:$PATH"

# 复制配置文件
COPY TG/tgbot.toml /telegram-bot-asf/

# 设置时区
RUN apt-get update && apt-get install -y tzdata && \
    echo "Asia/Shanghai" > /etc/timezone && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 复制ASF目录和启动脚本
COPY ASF/ /asf/
COPY entry.sh .

# 赋予启动脚本执行权限
RUN chmod +x entry.sh

# 暴露端口
EXPOSE ${PORT}

# 设置入口点和默认命令
ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
CMD [ ". /telegram-bot-asf/venv/bin/activate && ./entry.sh" ]
