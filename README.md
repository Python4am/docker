# jksb_sysu_docker
本仓库基于[jksb_sysu](https://github.com/tomatoF/jksb_sysu "中山大学健康傻逼")，将其使用docker部署。
## 使用方法：
首先需要编写config.json。将仓库内给出的config.json保存到物理机上，并修改对应参数。
```json
[
    {
        "username": "user1", # netid
        "password": "pass", # netid密码
        "mail_host": "smtp.qq.com", #发送邮件使用的smtp服务器
        "mail_user":"xx@qq.com", #发送邮件的邮箱地址
        "mail_token": "token", #密码/特定的token
        "mail_receiver": "receiver@qq.com" #接收申报结果的邮箱
    },
    {
        "username": "user2",
        "password": "pass"
    }
]
```
假设此config.json保存在/root/目录下。随后，拉取申报镜像。
```docker
docker pull quinv33/sysu_jksb:latest
```
拉取完成后，按如下命令运行容器，注意需要将/root/config.json改成相应存放位置。
```docker
docker run -d -v /root/config.json:/config.json quinv33/sysu_jksb:latest 
```
容器内tzdata已调节为北京时区。容器正常运行后会在每天早上7:30准时进行申报，并发送邮件告知申报结果。
