# You can use whatever distro you like, I prefer Ubuntu as that is  
# what is installed on my systems, servers and VMs for Linux 
FROM ubuntu:25.04 as builder 
 
# Tell it which version of Nmap you’d like to build, I tested with  
# 7.95   
ARG nmap_ver=7.95  
   
#  
# Install all required packages and system dependencies  
# I built this in a VM first to get all the requirements 
#  
# Compile and install Nmap from sources and download the vulners  
# NSEs 
RUN set -eux; \  
	apt-get update; \  
	apt-get install -y --no-install-recommends \  
	build-essential \
	automake \  
	libgcrypt20-dev \  
	openssl \  
	zlib1g \  
	ca-certificates \  
	libssh-4 \  
	liblua5.2-dev \  
	libssl-dev \  
	libssh2-1-dev \  
	curl \  
	git && \  
	curl -fL -o /tmp/nmap.tar.bz2 https://nmap.org/dist/nmap-${nmap_ver}.tar.bz2 && \  
	tar -xjf /tmp/nmap.tar.bz2 -C /tmp && \  
	cd /tmp/nmap* && \  
	ln -s /usr/bin/automake /usr/local/bin/automake-1.16 && \ 
	ln -s /usr/bin/aclocal /usr/local/bin/aclocal-1.16 && \ 
	./configure \  
    	--prefix=/opt \  
    	--sysconfdir=/opt/etc \  
    	--mandir=/opt/share/man \  
    	--infodir=/opt/share/info \  
    	--without-zenmap \  
    	--without-nmap-update \  
    	--without-ndiff \  
    	--without-nping \  
    	--without-ncat \  
    	--with-openssl=/usr/lib \  
    	--with-liblua=/usr/include && \  
	make && make install && \  
	git clone https://github.com/vulnersCom/nmap-vulners /opt/share/nmap/scripts/vulners && \  
	/opt/bin/nmap --script-updatedb
   
FROM ubuntu:25.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libgcrypt20 \
        zlib1g \
        libssh-4 \
        liblua5.2-0 \
        libssl3 \
        libssh2-1 \
        ca-certificates && \
    update-ca-certificates && \  
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt /opt

ENTRYPOINT ["/opt/bin/nmap"]

