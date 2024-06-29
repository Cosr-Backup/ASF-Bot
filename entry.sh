#!/bin/bash
# 激活虚拟环境
source /telegram-bot-asf/venv/bin/activate
# 运行你的Python脚本
nohup python /telegram-bot-asf/telegram-asf.py tgbot.toml > /dev/null 2>&1 &
bash /asf/ArchiSteamFarm-Service.sh  --process-required --service
