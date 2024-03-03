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
          include-files: '.*\.sh'  # default value - include all files
          exclude-files: ''        # default value - exclude no files
```

See above for more regex examples.
The badge will be generated in image-data branche of your repository. For this you need to configure [Setting the permissions of the GITHUB_TOKEN for your repository](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#setting-the-permissions-of-the-github_token-for-your-repository).
