#!/bin/sh
# Refresh the demo from the private app repo.
# Usage: sh update-demo.sh ../loopool-app   (run `npm run build` in loopool-app first)
set -e
APP="${1:-../loopool-app}"
python3 - "$APP/dist/index.html" app.html <<'PY'
import sys
src, out = sys.argv[1], sys.argv[2]
s = open(src, encoding='utf-8').read()
assert 'const API_BASE = ""' in s, 'not a local-mode build: run npm run build in loopool-app'
banner = ('<body>\n<div id="demo-banner" style="background:#2b3a55;color:#e8eefc;font:13px/1.4 system-ui,-apple-system,sans-serif;'
          'text-align:center;padding:6px 12px">Demo with sample data: nothing is saved, and reloading starts the sample bar over. '
          '<a href="./" style="color:#9cc4ff">All screens</a></div>')
i = s.index('<body>')
open(out, 'w', encoding='utf-8').write(s[:i] + banner + s[i + len('<body>'):])
print('app.html refreshed from', src)
PY
