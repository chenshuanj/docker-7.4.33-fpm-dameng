# docker-php7.4.33-fpm-dameng
docker制作php 7.4支持达梦数据库驱动的容器

```
#拉官方数据库镜像
docker pull xuxuclassmate/dameng:latest

docker run -d xuxuclassmate/dameng:latest
#获取容器id，假如是 [dameng-container-id]

#cd到本项目的目录
mkdir dmdbms

#把库文件提取出来
docker cp [dameng-container-id]:/opt/dmdbms/bin dmdbms/bin

#构建
docker build -t php:7.4.33-fpm-dm .
```
