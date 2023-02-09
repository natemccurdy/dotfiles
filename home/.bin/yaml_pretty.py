#!/usr/bin/env python3
import sys
try:
    import ruamel.yaml
except ImportError:
    sys.exit('Error, ruamel library not found. Try: pip3 install ruamel.yaml')


# Check if we have any data coming in on STDIN.
# isatty() returns false when there's something on STDIN.
if sys.stdin.isatty():
    sys.exit('Nothing detected on STDIN. Please pipe in some YAML.')


yaml = ruamel.yaml.YAML()
yaml.indent(mapping=2, sequence=4, offset=2)
yaml.default_flow_style = False
yaml.explicit_start = True
yaml.preserve_quotes = True


# Represent null values as ~ instead of blanks
# https://stackoverflow.com/a/44314840
def custom_null(self, data):
    return self.represent_scalar(u'tag:yaml.org,2002:null', u'~')


ruamel.yaml.RoundTripRepresenter.add_representer(type(None), custom_null)

# Load a single document from STDIN, then pretty print it.
# This does NOT support multiple documents at a time.
#yaml.dump(yaml.load(sys.stdin), sys.stdout)

# Load one or more documents from STDIN, then pretty print it.
for data in yaml.load_all(sys.stdin):
    yaml.dump(data, sys.stdout)
