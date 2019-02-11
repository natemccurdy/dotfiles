#!/usr/bin/env python
from ruamel.yaml import YAML
import sys

yaml=YAML()
yaml.indent(mapping=2, sequence=4, offset=2)
yaml.default_flow_style = False
yaml.explicit_start = True
yaml.preserve_quotes = True

yaml.dump(yaml.load(sys.stdin), sys.stdout)
