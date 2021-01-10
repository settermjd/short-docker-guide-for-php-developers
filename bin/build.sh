#!/usr/bin/env bash

USAGE="$(basename "$0") [-h] [-p] -- Generates a PDF full or preview copy of Docker: From Development to Deployed!.
where:
    -p  Generate preview copy of the book. By default the full copy of generated.
    -h  Print this help message"
BOOK_NAME="Docker: From Development to Deployed!"
BOOK_TYPE="FULL"
LATEST_TAG=$(git tag --list | head -n 1)
REVISION_DATE=$(date +'%B %d, %Y')
SOURCE_DIR="$(pwd)/source"
OUTPUT_FILE_PDF="build/book.pdf"

while getopts ":ph" opt; do
  case $opt in
    p)
      BOOK_TYPE="PREVIEW"
      ;;
    h)
      echo "$USAGE" && exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo "$USAGE" && exit 1
      ;;
  esac
done

# Set to "full" if not set to "preview"
if [ "$BOOK_TYPE" == "PREVIEW" ]
then
  BOOK_NAME="${BOOK_NAME} (Preview Copy)"
fi

#docker info | grep --silent "Error response from daemon" 2> /dev/null || echo "Docker is not running. Please start Docker before running this build script." && exit 1;

echo "Generating latest version of ${BOOK_NAME} [version: ${LATEST_TAG}] in PDF format."
if [ -e "${OUTPUT_FILE_PDF}" ]
then
    echo "Removing old version of the book"
    rm "${OUTPUT_FILE_PDF}"
    echo "${OUTPUT_FILE_PDF} deleted."
fi

# Generate the book
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
    -a book_name="${BOOK_NAME}" \
    -a type="${BOOK_TYPE}" \
    --safe-mode unsafe \
    -a allow-uri-read \
    --backend pdf \
    -d book \
    --base-dir "." \
    --out-file "${OUTPUT_FILE_PDF}" \
    "book.adoc"

echo "Latest version of ${BOOK_NAME} has been successfully generated."
echo "The PDF version is located in: ${SOURCE_DIR}/${OUTPUT_FILE_PDF}."
echo "The revision number is ${LATEST_TAG}."
echo "The revision date is ${REVISION_DATE}."

exit 0
