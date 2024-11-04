FROM ubuntu:noble
ENV SAVA_VERSION=1.6.0-rc

RUN apt update && \
    apt -y install cups cups-bsd printer-driver-escpr \
    poppler-utils qpdf imagemagick wkhtmltopdf librsvg2-bin \
    avahi-daemon avahi-discover libnss-mdns \
    wget gnupg curl binutils cpio \
    default-jdk

RUN useradd -r savapage && \
    usermod -s /bin/bash savapage && \
    usermod -d /opt/savapage savapage && \
    usermod -a -G lpadmin savapage

RUN mkdir -p /opt/savapage && \
    chown -R savapage:savapage /opt/savapage && \
    cd /opt/savapage && \
    if [ ! -f savapage-setup-linux.bin ]; then \
        wget --no-verbose https://www.savapage.org/download/snapshots/savapage-setup-${SAVA_VERSION}-linux-x64.bin -O savapage-setup-linux.bin && \
	chmod +x savapage-setup-linux.bin && \
        su savapage sh -c "./savapage-setup-linux.bin -n" && \
        /opt/savapage/MUST-RUN-AS-ROOT; \
    fi

VOLUME /etc/cups
VOLUME /opt/savapage

WORKDIR /opt/savapage

CMD ["sh", "-c", "/etc/init.d/cups start && (/opt/savapage/server/bin/linux-x64/app-server start &) && /usr/bin/bash"]

EXPOSE 8631 8632
