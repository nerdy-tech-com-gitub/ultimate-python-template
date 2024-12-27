# Build stage
FROM python:3.12-slim AS builder

# Update image
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*
# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Install the project without the the source code (only dependencies)  
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project --no-dev --compile-bytecode

# Install the project's source packages
ADD .python-version pyproject.toml uv.lock src/ /app/

RUN --mount=type=cache,target=/root/.cache/uv \
    uv pip install --compile-bytecode .

# Use alpine for the final image to reduce the total size
FROM python:3.12-alpine

# Copy the installed environment from builder
COPY --from=builder --chown=app:app /app /app

# Set working directory
WORKDIR /app

# Configure PATH for executables, packages are in the /app/.venv folder
ENV PATH="/app/.venv/bin:$PATH"

# Run command
CMD ["make_me_laugh"]