#!/bin/env bash

for dir in */; do
  dir="${dir%/}"
  echo "Stowing: $dir"
  stow "$dir"
done
