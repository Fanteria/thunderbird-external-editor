#!/bin/bash

SCRIPTPATH=$(dirname "$(realpath "$0")")

INPUT_FILE="$1"
EMAILS_DIR=$(mktemp -d)

HEADER="$EMAILS_DIR/header.eml"
EXTEDITOR="$EMAILS_DIR/exteditor.txt"
BODY="$EMAILS_DIR/body.md"
SIGNATURE="$EMAILS_DIR/signature.md"
PREVIOUS="$EMAILS_DIR/previous.html"
EMAIL=$EMAILS_DIR/email.md

awk -v header="$HEADER" \
  -v exteditor="$EXTEDITOR" \
  -v body="$BODY" \
  -v signature="$SIGNATURE" \
  -v previous="$PREVIOUS" \
  -f "$SCRIPTPATH/deserialize.awk" "$INPUT_FILE" 

echo "</body></html>" >> "$BODY"

cat "$BODY" > "$EMAILS_DIR/text.html"

pandoc "$BODY" -f html -t markdown -o "$BODY"

{ 
echo '---' ;
cat "$HEADER";
echo '---';
echo '';
cat "$BODY";
} > "$EMAIL"

dos2unix "$EMAIL"

kitty --start-as=normal -- nvim "+$(($(wc -l < "$HEADER") + 2))" "$EMAIL" 

awk -v header="$HEADER" \
  -v body="$BODY" \
  -f "$SCRIPTPATH/serialize.awk" "$EMAILS_DIR/email.md"

pandoc "$BODY" -f markdown -t html -s -o "$BODY" --css="$SCRIPTPATH/custom.css"

{ 
cat "$HEADER";
cat "$EXTEDITOR";
echo ""
sed -e 's|</body>||' -e 's|</html>||' "$BODY"
cat "$SIGNATURE";
cat "$PREVIOUS";
} > "$INPUT_FILE"

rm -r "$EMAILS_DIR"
