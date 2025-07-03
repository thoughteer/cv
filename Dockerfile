FROM ubuntu:25.10@sha256:dd397d3b5e4896054db111cb5145c0c08a6e7a669537e750e79e0385f2d69207

WORKDIR /cv

RUN apt-get clean && apt-get update

RUN apt-get install -y --no-install-recommends \
    biber \
    build-essential \
    ghostscript \
    texlive \
    texlive-bibtex-extra \
    texlive-fonts-extra \
    texlive-latex-extra

RUN apt-get install -y --no-install-recommends \
    pdf2svg

RUN apt-get install -y --no-install-recommends \
    texlive-lang-cyrillic

ADD Makefile /cv

USER ubuntu
ENTRYPOINT ["make"]
