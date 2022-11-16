FROM --platform=amd64 ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

# --- Installing packages
RUN apt-get update -q && apt-get install -qy \
    curl jq \
    texlive-full \
    python-pygments gnuplot \
    make git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data

ENTRYPOINT [ "pdflatex" ]

VOLUME ["/data"]
