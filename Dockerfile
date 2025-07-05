FROM ubuntu:noble

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

ENTRYPOINT ["make"]
