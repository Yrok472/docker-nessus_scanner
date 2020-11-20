FROM centos:7

ENV LINKING_KEY  ""
ENV SCANNER_NAME ""
ENV MANAGER_HOST ""
ENV MANAGER_PORT ""
ENV PROXY_HOST   ""
ENV PROXY_PORT   ""
ENV PROXY_USER   ""
ENV PROXY_PASS   ""
ENV PROXY_AGENT  ""
ENV LICENSE      ""
ENV ADMIN_USER   "admin"
ENV ADMIN_PASS   ""
ENV PRODUCT_INITIALIZATION   "true"

COPY nessus_startup.sh nessus_adduser.exp /usr/bin/
COPY yum.repo /etc/yum.repos.d/Tenable.repo
COPY gpg.key /etc/pki/rpm-gpg/RPM-GPG-KEY-Tenable

RUN    yum -y -q install Nessus expect java-11-openjdk-headless         \
    && yum -y -q clean all                                              \
    && chmod 755 /usr/bin/nessus_startup.sh                             \
    && chmod 755 /usr/bin/nessus_adduser.exp                            \
    && rm -f /opt/nessus/var/nessus/*.db*                               \
    && rm -f /opt/nessus/var/nessus/master.key                          \
    && rm -f /opt/nessus/var/nessus/uuid                                \
    && rm -f /opt/nessus/var/nessus/CA/cakey.pem                        \
    && rm -f /opt/nessus/var/nessus/CA/serverkey.pem                    \
    && rm -rf /tmp/*                                                    \
    && mkdir -p /first_start                                            \
    && cp -r /opt/nessus/ /first_start/                                 \
    && echo -e "export PATH=$PATH:/opt/nessus/bin:/opt/nessus/sbin" >> /etc/bashrc

EXPOSE 8834
CMD ["/usr/bin/nessus_startup.sh"]