#!/bin/bash

SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-2remove}
TARGET_DIR=${3:-bakap}

if [[ ! -e ${TARGET_DIR} ]]; then
    mkdir ${TARGET_DIR}
fi

ITEMS=$(cat ${RM_LIST})

for ITEM in ${ITEMS}; do

    if [[ -e "$SOURCE_DIR/$ITEM" ]]; then
    rm -rf ${SOURCE_DIR}/${ITEM}
    fi
done

for ITEM in ${SOURCE_DIR}/*; do
    if [[ -d "$ITEM" ]]; then
        cp -r "${ITEM}" "${TARGET_DIR}/"
    elif [[ -f "$ITEM" ]]; then
        mv "${ITEM}" "${TARGET_DIR}/"
    fi
done


AMOUNT=$(ls -1 "${SOURCE_DIR}" | wc -l)

if [ $AMOUNT -gt 0 ]; then
    echo "Jeszcze cos zostalo"

    if [ $AMOUNT -gt 1 ]; then
        echo "Zostaly co najmniej 2 pliki"
    fi
    if [ $AMOUNT -gt 4 ]; then
        echo "Zostalo wiecej niz 4 pliki"
    fi
    if [ $AMOUNT -gt 1 ] && [ $AMOUNT -lt 4 ]; then
        echo "Zostaly co najmniej 2 pliki ale maksymalnie 4"
    fi
else
    echo "Nie zostal zaden plik"
fi


filebakap="bakap_$(date +"%Y-%m-%d").zip"
zip -r "${filebakap}" "${TARGET_DIR}"

    
