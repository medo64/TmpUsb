#!/bin/bash

if [ -t 1 ]; then
    ANSI_RESET="$(tput sgr0)"
    ANSI_RED="`[ $(tput colors) -ge 16 ] && tput setaf 9 || tput setaf 1 bold`"
    ANSI_YELLOW="`[ $(tput colors) -ge 16 ] && tput setaf 11 || tput setaf 3 bold`"
    ANSI_CYAN="`[ $(tput colors) -ge 16 ] && tput setaf 14 || tput setaf 6 bold`"
fi

trap "echo -n \"$ANSI_RESET\" ; exit 255" SIGHUP SIGINT SIGQUIT SIGPIPE SIGTERM
trap "echo -n \"$ANSI_RESET\"" EXIT

PROJECT_DIR="$1"
IMAGE_PATH="$2"
SERIAL="$3"
OUTPUT="$4"

if [[ "$PROJECT_DIR" == "" ]]; then
    echo "${ANSI_RED}No project directory specified!${ANSI_RESET}" 2>&1
    exit 1
else
    echo "Project directory .: ${ANSI_CYAN}$PROJECT_DIR${ANSI_RESET}"
fi

if [[ "$IMAGE_PATH" == "" ]]; then
    echo "${ANSI_RED}No iamge path specified!${ANSI_RESET}" 2>&1
    exit 1
else
    echo "Image path ........: ${ANSI_CYAN}$IMAGE_PATH${ANSI_RESET}"
    if [[ $IMAGE_PATH != *.hex ]]; then
        echo "${ANSI_YELLOW}Ignoring file at $IMAGE_PATH as it does not have a .hex extension.${ANSI_RESET}" 2>&1
        exit 0
    fi
fi

INPUT="$PROJECT_DIR/$IMAGE_PATH"
echo "Input file ........: ${ANSI_CYAN}$INPUT${ANSI_RESET}"

if [[ "$SERIAL" == "" ]]; then
    echo "${ANSI_RED}No serial specified!${ANSI_RESET}" 2>&1
    exit 1
elif [[ "${#SERIAL}" -ne 7 ]]; then
    echo "${ANSI_RED}Serial must be 7 characters in length!${ANSI_RESET}" 2>&1
    exit 1
else
    echo "Original serial ...: ${ANSI_CYAN}$SERIAL${ANSI_RESET}"
fi

SERIAL_UNICODE=`echo -n "$SERIAL" | xxd -p -u | sed 's/../&00/g'`

NEW_SERIAL=`dd if=/dev/urandom bs=5 count=1 2>/dev/null | base32 | cut -c 1-7`
NEW_SERIAL_UNICODE=`echo -n "$NEW_SERIAL" | xxd -p -u | sed 's/../&00/g'`

echo "New serial ........: ${ANSI_CYAN}$NEW_SERIAL${ANSI_RESET}"

LINE=`cat "$INPUT" | grep "$SERIAL_UNICODE"`
echo "Original line .....: ${ANSI_CYAN}$LINE${ANSI_RESET}"

if [[ "$LINE" == "" ]]; then
    echo "${ANSI_RED}Serial not found, presumably already replaced.${ANSI_RESET}" 2>&1
    exit 1
fi

LINE_COUNT=`echo -n "$LINE" | wc -l`
if [[ "$LINE_COUNT" -ne 0 ]]; then
    echo "${ANSI_RED}Cannot match serial uniquely!${ANSI_RESET}" 2>&1
    exit 1
fi

NEW_LINE=`echo -n "$LINE" | sed "s/$SERIAL_UNICODE/$NEW_SERIAL_UNICODE/g"`

# Calculate checksum
NEW_NEW_LINE=":"
CHECKSUM=0
for ((i = 1; i < $(( ${#NEW_LINE} - 2 )); i += 2)); do
    BYTE_HEX="${NEW_LINE:$i:2}"
    NEW_NEW_LINE="$NEW_NEW_LINE$BYTE_HEX"
    BYTE_VALUE=$(printf "%d" 0x$BYTE_HEX)
    CHECKSUM=$(( (CHECKSUM + BYTE_VALUE) % 256 ))
done
CHeCKSUM_HEX=`printf "%02X" $(( (~CHECKSUM + 1) % 256 )) | tail -c 2`
NEW_NEW_LINE="$NEW_NEW_LINE$CHeCKSUM_HEX"
echo "New line ..........: ${ANSI_CYAN}$NEW_NEW_LINE${ANSI_RESET}"

# Final replacement
sed -i "s/$LINE/$NEW_NEW_LINE/g" "$INPUT"
if [[ $? -ne 0 ]]; then
    echo "${ANSI_RED}Serial number line replacement failed!${ANSI_RESET}" 2>&1
    exit 1
fi

# Touch all C files to force rebuild
find "$PROJECT_DIR" -mindepth 1 -maxdepth 1 -type f -name "*.c" -exec touch {} \;

# Extra copy
if [[ "$OUTPUT" != "" ]]; then
    echo "Output file .......: ${ANSI_CYAN}$OUTPUT${ANSI_RESET}"
    cp "$INPUT" "$OUTPUT"
    if [[ $? -ne 0 ]]; then
        echo "${ANSI_RED}Serial number line replacement failed!${ANSI_RESET}" 2>&1
        exit 1
    fi
fi
