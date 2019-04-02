#!/usr/bin/env python
import sys
try:
    import ruamel.yaml
except ImportError:
    sys.exit('Error, ruamel library not found. Try: pip3 install ruamel.yaml')

yaml = ruamel.yaml.YAML
yaml.indent(mapping=2, sequence=4, offset=2)
yaml.default_flow_style = False
yaml.explicit_start = True
yaml.preserve_quotes = True


# Represent null values as ~ instead of blanks
# https://stackoverflow.com/a/44314840
def custom_null(self, data):
    return self.represent_scalar(u'tag:yaml.org,2002:null', u'~')


ruamel.yaml.RoundTripRepresenter.add_representer(type(None), custom_null)

yaml.dump(yaml.load(sys.stdin), sys.stdout)
