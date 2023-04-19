[![PyPI version](https://badge.fury.io/py/mdiicons.svg)](https://badge.fury.io/py/mdiicons)

# mdi-py
Material Design SVG strings for Python

This library uses the mdi font from [Pictogrammers.com](https://pictogrammers.com/docs/library/mdi/getting-started/webfont/) to generate a python compatible dict.

## Examples

```py
from mdiicons import MDI

svg = MDI.get_icon("account", "#f00")
```

# Dependencies

- [opentypesvg](https://pypi.org/project/opentypesvg/) to get the svgs from the mdi font
