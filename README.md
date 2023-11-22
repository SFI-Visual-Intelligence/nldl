# NLDL Conference Style Template

This repository contains the LaTeX style template for the NLDL Conference. The template follows the official guidelines provided by the conference and is intended to ensure consistency and quality across all submissions.

## Usage

To use the NLDL Conference style template, simply download the [`authorkit.zip` file](https://github.com/SFI-Visual-Intelligence/nldl/releases/latest/download/authorkit.zip) from the [latest release](https://github.com/SFI-Visual-Intelligence/nldl/releases/latest), and extract the `nldl.cls` into your working directory or in your local `texmf`.  See details about the [installation](#installation) as well.

Use it in your document as a class:
```
\documentclass[fullpaper]{nldl}
```

Additionally, you can use the `main.tex` as a guideline for your paper, and delete all the information within the `document` environment.  You should familiarize yourself with the guidelines in any of the templates available in the [`templates.zip` file](https://github.com/SFI-Visual-Intelligence/nldl/releases/latest/download/templates.zip) from the [latest release](https://github.com/SFI-Visual-Intelligence/nldl/releases/latest).

## Installation

You can install the template in your local `texmf` instead of downloading it in your local directory.

### Download

You can use the code below to download the latest release and unpack it in your home for TeX and Metafont (`texmfhome`).

```bash
# Fetch where you have your texmf home
texmf=$(kpsewhich --var-value TEXMFHOME)
# In case you don't have the structure, you have to create it
mkdir -p ${texmf}/tex/latex/
cd ${texmf}/tex/latex
wget https://github.com/SFI-Visual-Intelligence/nldl/releases/latest/download/authorkit.zip
unzip authorkit.zip -d nldl
rm authorkit.zip
```

### Clone

The following code will clone the release for `NLDLYYYY` repository into your local TeX and Metafont home.  For instance, if you want to download the version from `NLDL0042` then you should use this value after `--branch` option replacing `NLDLYYYY`. 

```bash
# Fetch where you have your texmf home
texmf=$(kpsewhich --var-value TEXMFHOME)
# In case you don't have the structure, you have to create it
mkdir -p ${texmf}/tex/latex/
# Clone the latest repo
git clone git@github.com:SFI-Visual-Intelligence/nldl.git --branch NLDLYYYY
```

If you omit the `--branch NLDLYYYY` option, you will get the latest version of the NLDL template.

## Contributions

Contributions to this repository are welcome in the form of bug reports, feature requests, and merge requests. If you encounter any issues with the style template or notice any errors or inconsistencies, please report them in the issue tracker. Merge requests with fixes for these issues are also welcome and will be reviewed promptly.

Please note that all contributions should be made in accordance with the standards and guidelines provided by the NLDL Conference.


