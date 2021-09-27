# jksb_sysu_docker
本仓库基于[jksb_sysu](https://github.com/tomatoF/jksb_sysu "中山大学健康傻逼")的实现，将其使用docker部署。目前在x86_64的linux虚拟机、openwrt上进行了测试。
**树莓派版本镜像仍在测试中，并未证实可以部署，请谨慎使用，避免被智*院通报批评**
<br>**FUCK YOU, zgb!**
## 9-26 镜像更新说明：
近期发现在早上7：30的申报成功率较低，因此改成早上8：20申报一次，并且分别在9：00和9：40检查申报成功与否。
## 使用方法：
首先需要编写config.json。将仓库内给出的config.json保存到物理机上，并按如下注释修改相应的参数。
<br>**以下代码段中的注释仅为方便使用者理解而给出，实际使用请删除注释，否则程序将无法正常运行！**
<br>可选择使用email或者sckey方式进行推送。微信推送方式获取wxsend_key的具体方法可参考https://sct.ftqq.com/sendkey
```json
[
    {
        "method": "sckey", # 此处输入sckey将使用sckey方式推送信息，如果输入email则发送email，输入tgbot则(未实现)
        "username": "user1", # netid
        "password": "pass", # netid密码
        "mail_host": "smtp.qq.com", #发送邮件使用的smtp服务器，若使用sckey方法可以留空
        "mail_user":"xx@qq.com", #发送邮件的邮箱地址，若使用sckey方法可以留空
        "mail_token": "token", #密码/特定的token，若使用sckey方法可以留空
        "mail_receiver": "receiver@qq.com", #接收申报结果的邮箱，若使用sckey方法可以留空
        "wxsend_key":"" #server酱申请到的send_key，若使用email方法可以留空
    },
    {
        "username": "user2",
        "password": "pass"
    }
]
```
假设此config.json保存在/root/目录下，按如下命令启动并持久化运行容器，注意需要将/root/config.json改成配置文件的相应存放位置。
```docker
docker run -id -v /root/config.json:/config.json quinv33/sysu_jksb:latest 
```
容器内tzdata已调节为北京时区。容器正常运行后会在每天早上8：20准时进行申报，并发送邮件告知申报结果。

