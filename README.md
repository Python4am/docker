# jksb_sysu_docker
本仓库存储将jksb_sysu使用docker部署的dockerfile
使用方法：
生成镜像后，在你想要的物理机位置编写config.json，假设为/root/config.json
然后运行：
docker run -d -v /root/config.json:/config.json {生成镜像名} 
随后会在每天早上7:30准时进行申报，容器内时区已调成+8。