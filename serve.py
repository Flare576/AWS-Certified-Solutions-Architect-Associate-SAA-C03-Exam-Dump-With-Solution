"""Serve this folder on 127.0.0.1 only. Binds first, then drops root so a privileged port (80) never means a root-run server."""
import functools
import http.server
import os
import sys

port = int(sys.argv[1]) if len(sys.argv) > 1 else 80
root = os.path.dirname(os.path.abspath(__file__))
handler = functools.partial(http.server.SimpleHTTPRequestHandler, directory=root)
server = http.server.ThreadingHTTPServer(("127.0.0.1", port), handler)

if os.name != "nt" and os.geteuid() == 0 and os.environ.get("SUDO_UID"):
    os.setgroups([])
    os.setgid(int(os.environ["SUDO_GID"]))
    os.setuid(int(os.environ["SUDO_UID"]))

try:
    server.serve_forever()
except KeyboardInterrupt:
    pass
