# CV

[An unsophisticated yet neatly crafted LaTeX template for a CV.](#example)

## License

This CV template is released under the MIT license.

## Usage

Install [Docker](https://docs.docker.com/install/).

On a non-Linux or non-AMD64 machine (e.g. macOS), run
```bash
docker build -t thoughteer/cv .
```
once.

Edit `cv.tex` and `publications.bib` (if any), then run
```bash
./make.sh
```
to produce `cv.pdf`.

You can change the target language by passing an additional argument as in
```bash
./make.sh language=russian
```
The default language is `english`.

To clean up after compilation, run
```bash
./make.sh clean
```
Note that this will also remove the PDF.

## Customization

#### Color scheme

Just redefine colors in the *Colors* section of `cv.cls`.

#### Additional LaTeX packages

Add missing packages to the `Dockerfile` file, then run
```bash
docker build -t thoughteer/cv .
```

## Example

![CV](cv.svg)
