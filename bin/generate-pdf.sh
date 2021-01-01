#!/bin/bash
##
## This script will generate, from the available source files, an PDF copy of the book.
##

## ---------------------- ##
## Variables
## ---------------------- ##
FILE_NAME=ze.pdf
BUILD_DIR=./build/

##
## Generate the book
##
function generate_book()
{
  pandoc -S -o "$BUILD_DIR/$FILE_NAME" --number-sections --normalize --smart --epub-metadata=metadata.xml --toc --toc-depth=2 --epub-stylesheet=stylesheet.css title.md dedication.md introduction.md gettingstarted.md 01-synopsis.md 02-who-am-i.md 03-why-this-book.md 05-what-is-a-microapplication.md 06-what-is-expressive.md 07-ze-core-components.md 08-create-a-basic-application.md 09-add-database-support.md 10-add-middleware.md 11-conclusion.md 12-links.md
}

generate_book

