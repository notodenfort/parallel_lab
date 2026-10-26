#!/usr/bin/env bash
# Замер на Linux/macOS: ./measure.sh
echo "Ядер: $(python -c 'import os;print(os.cpu_count())')" | tee results.txt
for cmd in "pytest -q" "pytest -q -n 2" "pytest -q -n 4" "pytest -q -n auto"; do
  echo "== $cmd" | tee -a results.txt; $cmd 2>&1 | tail -1 | tee -a results.txt; done
