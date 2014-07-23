FROM webdizz/centos-java8:latest

MAINTAINER Izzet Mustafaiev "izzet@mustafaiev.com"

# Set correct environment variables.
ENV	HOME /root
ENV	LANG en_US.UTF-8
ENV	LC_ALL en_US.UTF-8

RUN	echo "root:123456" | chpasswd

RUN yum install -y pwgen openssh-server openssh-clients python-setuptools; yum upgrade -y; yum update -y;  yum clean all
RUN easy_install supervisor

#SSH support
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN /etc/init.d/sshd start && /etc/init.d/sshd stop
RUN mkdir -p /etc/supervisor/conf.d; mkdir -p /var/log/supervisor
ADD /supervisor/supervisord.conf /etc/supervisord.conf
ADD /supervisor/supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22

CMD ["/run.sh"]
