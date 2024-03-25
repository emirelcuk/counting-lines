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

while getopts 'c:e:f:i:o:r:s:x:' opt; do
  case "$opt" in
    c)
      Color="$OPTARG"
      ;;
    e)
      ExcludeDirs="$OPTARG"
      ;;
    f)
      Filename="$OPTARG"
      ;;
    i)
      IncludeFiles="$OPTARG"
      ;;
    o)
      OutDir="$OPTARG"
      ;;
    r)
      Rounding="$OPTARG"
      ;;
    s)
      ScanDirs="$OPTARG"
      ;;
    x)
      ExcludeFiles="$OPTARG"
      ;;
    :)
      echo "Usage: $(basename "$0") [-c Color] [-e ExcludeDirs] [-f Filename] [-i IncludeFiles] \
[-o OutputDir] [-r Rounding] [-s ScanDirs] [-x ExcludeFiles]"
      exit 1
      ;;
    ?)
      echo "Usage: $(basename "$0") [-c Color] [-e ExcludeDirs] [-f Filename] [-i IncludeFiles] \
[-o OutputDir] [-r Rounding] [-s ScanDirs] [-x ExcludeFiles]"
      exit 1
      ;;
  esac
done

ExcludeDirectories=()
if [ "$ExcludeDirs" ]; then
  IFS=$'\n' read -rd '' -a array <<< "$ExcludeDirs"
  for word in "${array[@]}"; do
    ExcludeDirectories+=('!' '-path' "*/$word/*")
  done
fi

ScanDirectories=()
if [ "$ScanDirs" ]; then
  IFS=$'\n' read -rd '' -a array <<< "$ScanDirs"
  for word in "${array[@]}"; do
    ScanDirectories+=("$word")
  done
fi

Count=0
while read -r FILE; do
  lines=$(grep -cve '^\s*$' < "$FILE");
  (( Count+=lines ));
done < <(find "${ScanDirectories[@]}" \
-type f \
-regextype posix-egrep \
-regex "$IncludeFiles" \
! -regex "$ExcludeFiles" "${ExcludeDirectories[@]}")

echo "Lines of Code: $Count"

if   [ "$Rounding" == "K" ]; then Count="$(python -c "print(round($Count/1000, 1))")K"
elif [ "$Rounding" == "M" ]; then Count="$(python -c "print(round($Count/1000000, 1))")M"
elif [ "$Rounding" == "G" ]; then Count="$(python -c "print(round($Count/1000000000, 1))")G"
else Count=$(python -c "print(format($Count, ',d'))")
fi

echo "Lines of code: $Count"

mkdir -p "$OutDir"

anybadge -l "Lines of Code" -v "$Count" -f "$OutDir/$Filename" -o -c "$Color"
