# 使用 Debian stable 作为基础镜像
FROM debian:stable

# 安装 Shellinabox 并清理 APT 缓存文件
RUN apt-get update && \
    apt-get install -y --no-install-recommends shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 创建一个新的非特权用户 'shelluser' 并设置密码
RUN useradd -m shelluser && \
    echo 'shelluser:password' | chpasswd

# 暴露 Shellinabox 默认端口
EXPOSE 22

# 启动 Shellinabox，使用 -t 参数禁用SSL，-s 参数指定服务
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
