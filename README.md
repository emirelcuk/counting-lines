# loc-badge-action
![Generated Button](https://github.com/MikhailEpatko/code-lines-counter-action/blob/image-data/total-lines.svg)

GitHub action to count lines in the files excluding blank lines.

## Examples of usage bash script

```./generate-badge.sh @1 @2```

    @1 = files to include (posix-egrep regex)
    @2 = files to exclude (posix-egrep regex)

See: https://www.gnu.org/software/findutils/manual/html_node/find_html/posix_002degrep-regular-expression-syntax.html

### Count lines in all files:

```./generate-badge.sh '.*\**' ''```

### Count lines in kotlin source files (*.kt):

```./generate-badge.sh '.*\.kt' ''```

### Count lines in kotlin and bash script files (*.kt, *.sh):

```./generate-badge.sh '.*\.(kt|sh)$' ''```

### Count lines in all files excluding bash script files (*.sh):

```./generate-badge.sh '.*\**' '.*\.sh'```

## Example of usage GitHub action

In this version, you use [posix-egrep](https://www.gnu.org/software/findutils/manual/html_node/find_html/posix_002degrep-regular-expression-syntax.html) to pass a regular expression to the action to exclude or include file lines counts.

In next releases it will be simplified. 

To install action copy the workflow code into a .github/workflows/main.yml file in your repository

```
on: [push]

jobs:
  lines_counter_job:
    runs-on: ubuntu-latest
    name: A job to count lines of code and generate badge
    steps:
      - uses: actions/checkout@v4
      - id: counting
        uses: ./                   # write the action name instead
        with:
          include-files: '.*\**'  # default value - include all files
          exclude-files: ''        # default value - exclude no files
```

See above for more regex examples.

The badge will be generated into ./output/total-lines.svg file. Use whatever tool you prefer to upload it somewhere.
