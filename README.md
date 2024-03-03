# code-lines-counter-action
![Generated Button](https://github.com/MikhailEpatko/code-lines-counter-action/blob/image-data/total-lines.svg)

GitHub action to count lines in the files excluding blank lines.

## Examples of usage bash script

```./count.sh @1 @2```

    @1 = files to include (posix-egrep regex)
    @2 = files to exclude (posix-egrep regex)

See: https://www.gnu.org/software/findutils/manual/html_node/find_html/posix_002degrep-regular-expression-syntax.html

### Count lines in all files:

```./count.sh '.*\**' ''```

### Count lines in kotlin source files (*.kt):

```./count.sh '.*\.kt' ''```

### Count lines in kotlin and bash script files (*.kt, *.sh):

```./count.sh '.*\.(kt|sh)$' ''```

### Count lines in all files excluding bash script files (*.sh):

```./count.sh '.*\**' '.*\.sh'```

## Example of usage GitHub action

Copy the workflow code into a .github/workflows/main.yml file in your repository

```
on: [push]

jobs:
  lines_counter_job:
    runs-on: ubuntu-latest
    name: A job to count lines of code
    steps:
      - uses: actions/checkout@v4
      - id: counting
        uses: ./
        with:
          include-files: '.*\.sh'
```