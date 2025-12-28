import os
import pathlib
from flask import Flask, send_from_directory, request, make_response

BASE_DIR = pathlib.Path(__file__).parent

app = Flask(
    __name__,
    static_folder=str(BASE_DIR),
    static_url_path="",
)


def write_pid(pid_file: pathlib.Path) -> None:
    pid_file.write_text(str(os.getpid()), encoding="utf-8")


def remove_pid(pid_file: pathlib.Path) -> None:
    if pid_file.exists():
        pid_file.unlink()


@app.after_request
def set_security_headers(response):
    response.headers.setdefault("X-Content-Type-Options", "nosniff")
    response.headers.setdefault("X-Frame-Options", "SAMEORIGIN")
    response.headers.setdefault("Referrer-Policy", "strict-origin-when-cross-origin")
    response.headers.setdefault("Cache-Control", "public, max-age=3600")
    return response


@app.route("/")
def index():
    return send_from_directory(BASE_DIR, "index.html")


@app.errorhandler(404)
def not_found(_error):
    # Fallback per risorse statiche mancanti
    return make_response("Risorsa non trovata", 404)


def create_app():
    return app


def main():
    port = int(os.environ.get("PORT", "80"))
    pid_file = BASE_DIR / "server.pid"
    write_pid(pid_file)
    try:
        app.run(host="0.0.0.0", port=port, debug=False, use_reloader=False)
    finally:
        remove_pid(pid_file)


if __name__ == "__main__":
    main()
