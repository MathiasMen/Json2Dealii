#!/bin/bash

git submodule init
git submodule update

# Start new shell indicated by parenthesis
# so that the cd command is executed.
(cd dealii && cmake .)

(cd dealii && make -j 16 install)