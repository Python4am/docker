# jksb_sysu_docker
本仓库存储将jksb_sysu使用docker部署的dockerfile
使用方法：
生成镜像后，在你想要的物理机位置编写config.json，假设为/root/config.json
或者直接拉取编译好的镜像
docker pull quinv33/sysu_jksb:latest
然后运行：
docker run -d -v /root/config.json:/config.json quinv33/sysu_jksb:latest 
容器正常运行后，会在每天早上7:30准时进行申报，并使用配置里的邮箱详细发送邮件。
容器内时区已调成+8。