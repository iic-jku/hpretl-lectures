#!/usr/bin/env bash
# -------------------------------------------------
# Check that the slide tooling is identical in all lectures
# -------------------------------------------------
# SPDX-FileCopyrightText: 2026 Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits
# SPDX-License-Identifier: Apache-2.0
#
# Usage: ./check-slide-tools.sh
#
# slides/_tools/ of every lecture submodule must match the first one;
# the generated numbers.json is lecture-specific and not compared.

set -euo pipefail
cd "$(dirname "$0")"

LECTURES=(aicd rfic dcic)
REF=${LECTURES[0]}
status=0

for lec in "${LECTURES[@]:1}"; do
  if diff -rq -x numbers.json -x __pycache__ \
      "$REF/slides/_tools" "$lec/slides/_tools"; then
    echo "ok    $lec/slides/_tools matches $REF"
  else
    echo "FAIL  $lec/slides/_tools differs from $REF" >&2
    status=1
  fi
done

exit $status
