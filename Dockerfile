FROM ubuntu:25.10@sha256:10b61aabaaf0123f3670112057c3b3ccf27c808ddb892ba5a4e32366bff7f3fe

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
