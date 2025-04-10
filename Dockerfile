FROM php:7.4.33-fpm

#从 xuxuclassmate/dameng:latest 提取出
COPY dmdbms/bin/* /opt/dmdbms/bin/

#设置dameng环境变量
ENV LD_LIBRARY_PATH=/opt/dmdbms/bin:/usr/lib/

#dameng依赖
RUN apt-get update && apt-get install -y libaio1

#其他缺少的库一起安装了：redis、mysqli、pdo_mysql、sockets、gd
RUN pecl install redis && docker-php-ext-enable redis && docker-php-ext-install mysqli pdo_mysql sockets
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev && docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd

#清理
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#添加dameng extension
COPY libphp74_dm.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/
COPY php74_pdo_dm.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/
COPY dm.ini /usr/local/etc/php/conf.d/

#构建和测试
#docker build -t php:7.4.33-fpm-dm .
#docker run -it --rm php:7.4.33-fpm-dm php -m
#docker run -it --rm php:7.4.33-fpm-dm php -a