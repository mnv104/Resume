#!/bin/bash

latex resume.tex
dvips -t letter -o resume.ps resume.dvi
ps2pdf resume.ps resume.pdf

