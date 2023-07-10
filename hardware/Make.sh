#!/bin/bash

SRC_FILE="src/TmpUsb [B].kicad_pcb"

PROJECT_NAME=$(basename "$SRC_FILE" | cut -d'[' -f1 | xargs)
PROJECT_REV=$(basename "$SRC_FILE" | cut -d'[' -f2 | cut -d']' -f1 | xargs)
PROJECT_DATE="`date +%g%V`"

DIST_NAME="$PROJECT_NAME $PROJECT_REV$PROJECT_DATE"
DIST_DIR="dist/$DIST_NAME"
DIST_ZIP="dist/$DIST_NAME.zip"

if [ -e "$DIST_DIR" ]; then
    rm -rf "$DIST_DIR"
fi
mkdir -p "$DIST_DIR"

DIST_FILE="$DIST_DIR/$DIST_NAME.kicad_pcb"
cp "$SRC_FILE" "$DIST_FILE"
if [ -e "${SRC_FILE%.kicad_pcb}.md" ]; then
    cp "${SRC_FILE%.kicad_pcb}.md" "$DIST_DIR/$DIST_NAME.txt"
fi

sed -i 's/(gr_text "'$PROJECT_NAME' '$PROJECT_REV'...." /(gr_text "'$PROJECT_NAME' '$PROJECT_REV$PROJECT_DATE'" /g' "$DIST_FILE"

exit

kicad-cli pcb export gerbers --layers "Edge.Cuts,F.Cu,B.Cu,F.Silkscreen,B.Silkscreen,F.Mask,B.Mask,F.Paste,B.Paste" \
                             --output "$DIST_DIR/" \
                             "$DIST_FILE"

mv "$DIST_DIR"/*-Edge_Cuts.gm1 "$DIST_DIR/$DIST_NAME.gko"
mv "$DIST_DIR"/*-F_Cu.gtl "$DIST_DIR/$DIST_NAME.gtl"
mv "$DIST_DIR"/*-B_Cu.gbl "$DIST_DIR/$DIST_NAME.gbl"
mv "$DIST_DIR"/*-F_Silkscreen.gto "$DIST_DIR/$DIST_NAME.gts"
mv "$DIST_DIR"/*-B_Silkscreen.gbo "$DIST_DIR/$DIST_NAME.gbs"
mv "$DIST_DIR"/*-F_Mask.gts "$DIST_DIR/$DIST_NAME.gto"
mv "$DIST_DIR"/*-B_Mask.gbs "$DIST_DIR/$DIST_NAME.gbo"
mv "$DIST_DIR"/*-F_Paste.gtp "$DIST_DIR/$DIST_NAME.gtp"
mv "$DIST_DIR"/*-B_Paste.gbp "$DIST_DIR/$DIST_NAME.gbp"
rm "$DIST_DIR"/*-job.gbrjob

kicad-cli pcb export drill --output "$DIST_DIR/" \
                           "$DIST_FILE"

if [ -e "$DIST_ZIP" ]; then rm "$DIST_ZIP"; fi
zip "$DIST_ZIP" "$DIST_DIR"/*
rm -rf "$DIST_DIR"

echo $DIST_ZIP
