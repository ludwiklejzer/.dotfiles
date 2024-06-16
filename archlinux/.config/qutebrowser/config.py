"""Qutebrowser configuration file."""

# pylint: disable=C0111
from typing import Any

import bindings
import options
import theme
from qutebrowser.config.config import ConfigContainer  # type: ignore
from qutebrowser.config.configfiles import ConfigAPI  # type: ignore

# Ignore linters for global variables
# type: ignore
config: ConfigAPI
c: ConfigContainer
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

# Setup
options.setup(c, config)
theme.setup(c)
bindings.setup(config)
