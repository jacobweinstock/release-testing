#!/bin/bash

set -xeou pipefail

crane_binary="$1"
src="$2"
# destinations must be \n delimited.
destinations="$3"
echo "$destinations"

while IFS=',' read -r line; do
  # Process each line
  echo "Processing line: $line"
  ${crane_binary} copy "$src" "$line"
  if [ $? -ne 0 ]; then
    echo "Failed to copy $src to $line"
    exit 1
  fi
  echo "Successfully copied $src to $line"
done <<< "$destinations"