#!/bin/bash

marp presentation.md \
     --allow-local-files \
     --html \
     --theme gaia \
     -o index.html

marp presentation.md \
     --allow-local-files \
     --pdf \
     --theme gaia
