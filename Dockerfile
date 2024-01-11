
FROM docker.io/library/amazonlinux:2023 as builder

ENV PYTHON_VERSION=3.12.1

WORKDIR /root

RUN yum update -y && \
    yum install -y tar gzip make gcc g++ libffi-devel openssl-devel zlib-devel ncurses-devel gdbm-devel bzip2-devel xz-devel sqlite-devel libuuid-devel readline-devel && \
    curl -Lo python.tgz https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xzf python.tgz && \
    mv Python-${PYTHON_VERSION} python && \
    cd python && \
    ./configure --enable-optimizations --prefix /opt/python && \
    make install

FROM docker.io/library/amazonlinux:2023

COPY --from=builder /opt/python /opt/python

ENTRYPOINT [ "/opt/python/bin/python3" ]
