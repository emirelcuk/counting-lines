#!/bin/bash

# ---------------------------------------------
#  Count lines in the files excluding blank lines
#
#  @1 = files to include (posix-egrep regex)
#  @2 = files to exclude (posix-egrep regex)
#
#  EXAMPLES OF USAGE:
#    - count in all files:
#      ./count.sh '.*\**' ''
#
#    - count in kotlin source files (*.kt):
#      ./count.sh '.*\.kt' ''
#
#    - count in kotlin and bash script files (*.kt, *.sh):
#      ./count.sh '.*\.(kt|sh)$' ''
#
#    - count in all files excluding bash script files (*.sh):
#      ./count.sh '.*\**' '.*\.sh'
# ---------------------------------------------
total=0
while read -r FILE; do
  count=$(grep -cve '^\s*$' < "$FILE");
  (( total+=count ));
done < <(find . -type f -regextype posix-egrep -regex "$1" ! -regex "$2")
echo "Lines of Code: $total"

mkdir ./output
pip install anybadge
anybadge -l "Lines of Code" -v "$total" -f ./output/total-lines.svg -c royalblue
