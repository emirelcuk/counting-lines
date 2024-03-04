#!/bin/bash

# ---------------------------------------------
#  Count lines in the files excluding blank lines
#
#  @1 = files to include (posix-egrep regex)
#  @2 = files to exclude (posix-egrep regex)
#
#  EXAMPLES OF USAGE:
#    - count in all files:
#      ./generate-badge.sh '.*\**' ''
#
#    - count in kotlin source files (*.kt):
#      ./generate-badge.sh '.*\.kt' ''
#
#    - count in kotlin and bash script files (*.kt, *.sh):
#      ./generate-badge.sh '.*\.(kt|sh)$' ''
#
#    - count in all files excluding bash script files (*.sh):
#      ./generate-badge.sh '.*\**' '.*\.sh'
# ---------------------------------------------
total=0
while read -r FILE; do
  count=$(grep -cve '^\s*$' < "$FILE");
  (( total+=count ));
done < <(find . -type f -regextype posix-egrep -regex "$1" ! -regex "$2")
echo "Lines of Code: $total"

anybadge -l "Lines of Code" -v "$total" -f ./output/total-lines.svg -c royalblue
