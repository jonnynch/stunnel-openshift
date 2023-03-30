FROM centos

RUN cd /etc/yum.repos.d/ \
 && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
 && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*


RUN yum install -y stunnel openssl sed && yum clean all && \
    mkdir -p /etc/stunnel/config /etc/stunnel/pki
    
ADD config /etc/stunnel/config/config
ADD launch.sh /launch.sh

RUN chown -R 1001:0 /etc/stunnel /launch.sh && \
    chmod -R g+rw /etc/stunnel && \
    chmod ug+rwx /launch.sh
    
USER 1001
EXPOSE 33306

CMD /launch.sh