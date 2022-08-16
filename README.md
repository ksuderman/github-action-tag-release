# Tag and Release

Creates a `tag` and generates a GitHub Release for the current version.  The version can be specified as an input to the action or it can be extracted from a file.

## Inputs

- **file**<br/>
   The path to the file to read the version number from.  Ignored if `tag` is set.
- **parser**<br/>
   One of `awk` or `cat` and specifies what shell command to use to parse the version number. Ignored if `tag` is set.
- **draft**<br/>
  `true` or `false`. Set to `true` to create a draft release.  Default is `false`
- **tag** [optional]<br/>
  The version number to use. Overrides `file` and `parser`.

The version `file` should either be a text file containing only a single line with the version number:
```bash
version=$(cat $file)
```
or it should be a yaml-ish like file with a line starting with the string `version:`
```bash
version=$(cat $file | awk '/^version:/{ print $2 }')
```

## Example

```yaml
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: ksuderman/github-action-tag-release@v2
      env:
        GITHUB_TOKEN: ${{ github.token }}
      with:
        file: Chart.yaml
        parser: awk
```