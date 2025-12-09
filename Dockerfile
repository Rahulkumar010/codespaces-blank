# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7

ARG PYTHON_VERSION=3.12.1
FROM python:${PYTHON_VERSION}-slim AS base

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr.
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Create a non-privileged user that the app will run under.
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

# Copy only requirements first to leverage Docker layer caching.
COPY requirements.txt ./

# Install Python dependencies using a pip cache mount to speed rebuilds.
RUN --mount=type=cache,target=/root/.cache/pip \
    python -m pip install --upgrade pip --disable-pip-version-check \
    && python -m pip install --no-cache-dir --disable-pip-version-check -r requirements.txt

# Switch to the non-privileged user for runtime and copy application files.
USER appuser

# Copy application files and set ownership to the runtime user to avoid
# extra chown layers during container startup.
COPY --chown=appuser:appuser . .

# Healthcheck: uses Python's stdlib to query the local app; keeps the image
# self-contained (no curl/wget required). Adjust the path/port if necessary.
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request, sys; urllib.request.urlopen('http://127.0.0.1:5000')" || exit 1

EXPOSE 5000

CMD ["waitress-serve", "--host=0.0.0.0", "--port=5000", "server:app"]
