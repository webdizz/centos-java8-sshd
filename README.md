centos-java8-sshd
============

A docker build of the latest CentOS release with updates applied and java 8 installed ( based on image [webdizz/centos-java8](https://index.docker.io/u/webdizz/centos-java8/)) and SSHD included.


Description:
-------------

- CentOS 6.5 + Oracle Java 8 + SSHD

Versions:
-------------

- Build on blalor/centos:latest

Usage:
-------------

To run container with sample java command:

    docker run --rm webdizz/centos-java8-sshd java -version
    
To run container as daemon and connect over SSH:
    
    docker run -d -e ROOT_PASS="123456" -p 222:22 webdizz/centos-java8-sshd 
    ssh -p 222 root@localhost
