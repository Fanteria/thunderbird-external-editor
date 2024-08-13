# Thunderbird external editor

This is small project only to enable combine Markdown with [External Editor Revived](https://addons.thunderbird.net/en-GB/thunderbird/addon/external-editor-revived/).

## Usage
Install [External Editor Revived](https://addons.thunderbird.net/en-GB/thunderbird/addon/external-editor-revived/). In configuration as editor choose `Custom`, set shell as `sh` and set command template to:
```bash
/absolute/path/to/thunderbird-external-editor/external-editor.sh "/path/to/temp.eml"
```

For more information check [External Editor Revived wiki](https://github.com/Frederick888/external-editor-revived/wiki).
