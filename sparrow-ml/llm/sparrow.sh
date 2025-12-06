#!/bin/bash

DATE=$(date +"%Y-%m-%d %T")
FILE="out/output-ai-${DATE}.txt"
mkdir -p out
echo "--------------------------------" > "${FILE}"
echo "--- Sparrow LLM Engine Launcher ---" >> "${FILE}"
echo "--------------------------------" >> "${FILE}"

command -v python >/dev/null 2>&1 || { echo >&2 "Python is required but it's not installed. Aborting."; exit 1; }

# Check Python version
PYTHON_VERSION=$(python --version 2>&1) # Capture both stdout and stderr
echo "Detected Python version: $PYTHON_VERSION" >> "${FILE}"
if [[ ! "$PYTHON_VERSION" == *"3.12.11"* ]]; then
  echo "Python version 3.12.11 is required. Current version is $PYTHON_VERSION. Aborting." >> "${FILE}"
  exit 1
fi

PYTHON_SCRIPT_PATH="engine.py"

if [ "$1" == "assistant" ]; then
    PYTHON_SCRIPT_PATH="assistant.py"
    shift # Shift the arguments to exclude the first one
fi

python "${PYTHON_SCRIPT_PATH}" "$@" >> "${FILE}"

# make script executable with: chmod +x sparrow.sh