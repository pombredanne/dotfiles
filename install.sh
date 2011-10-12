#!/bin/bash
FILES=`find . -maxdepth 1 -not \( -name .git -o -name \. -o -name \.\. \)`
cp ${FILES} ${HOME} -r
