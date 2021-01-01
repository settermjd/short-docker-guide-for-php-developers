#!/bin/bash

#
# Need to test for git, otherwise LATEST_TAG cannot be set
#

BOOK_NAME="Mezzio Essentials"
LATEST_TAG=$(git tag --list | head -n 1)
REVISION_DATE=$(date +'%B %d, %Y')
SOURCE_DIR="$(pwd)/source"
OUTPUT_FILE_PDF="build/book.pdf"
OUTPUT_FILE_EPUB="build/book.pdf"

echo "Generating latest version of ${BOOK_NAME} [version: ${LATEST_TAG}] in PDF format."
if [ -e "${OUTPUT_FILE_PDF}" ]
then
    echo "Removing old version of the book"
    rm "${OUTPUT_FILE_PDF}"
    echo "${OUTPUT_FILE_PDF} deleted."
fi

docker run -it -v "${SOURCE_DIR}":/documents/ \
    asciidoctor/docker-asciidoctor \
    asciidoctor-pdf \
    -a pdf-stylesdir="resources/themes/" \
    -a pdf-fontsdir="resources/fonts/" \
    -a pdf-style="book" \
    -a imagesdir="resources/images/" \
    -a revnumber="${LATEST_TAG}" \
    -a revdate="${REVISION_DATE}" \
    -a rouge-style=base16.solarized \
    --safe-mode unsafe \
    -a allow-uri-read \
    --backend pdf \
    -d book \
    --base-dir "." \
    --out-file "${OUTPUT_FILE_PDF}" \
    "book.adoc"

if [ "$?" -eq 0 ]; then
    echo "Latest version of ${BOOK_NAME} has been successfully generated."
    echo "The PDF version is located in: ${SOURCE_DIR}/${OUTPUT_FILE_PDF}."
    echo "The ePub version is located in: ${SOURCE_DIR}/${OUTPUT_FILE_EPUB}."
    echo "The revision number is ${LATEST_TAG}."
    echo "The revision date is ${REVISION_DATE}."
    exit 0
else 
    return $?
fi;

