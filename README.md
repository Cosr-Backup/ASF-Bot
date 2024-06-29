# ASF-Bot
在Docker上运行asf以及[telegram bot](https://github.com/zhongfly/telegram-bot-asf)

## 使用方法简述
自编译Docker镜像

## 如何输入steam登录验证
每次修改Github项目中的文件后，Railway都会重新构建，会丢失登录状态，需要重新登录；或者将令牌导入到ASF中

由于限制，只能通过IPC输入验证

具体操作参见[ASF的相关介绍](https://github.com/JustArchiNET/ArchiSteamFarm/wiki/Commands-zh-CN#%E7%A4%BA%E4%BE%8B)

假定需要登录的BOT叫`me`，使用手机生成的 2FA 令牌登录

0. 打开ASF-UI的命令窗口或直接发送命令给telegram bot
1. `start me` -> 机器人会尝试登录，但因为缺少验证码而登录失败，然后因为 ASF 处于 Headless 模式，机器人会停止运行。 我们做这一步的目的是让 Steam 网络向我们发送验证码——否则我们就可以跳过这一步了。
2. `input me TwoFactorAuthentication ABCDE` -> 我们将 MySteamGuardBot 机器人的 2FA 令牌 输入设置为 ABCDE。 当然，这里的 ABCDE 需要换成我们收到的2FA验证码。
3. `start me` -> 我们重新启动已停止的机器人，这一次会自动使用我们在上一步中设置的验证码，登录将会成功，并且之前的验证码输入会被清除。
