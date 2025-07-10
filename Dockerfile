# ---- STAGE 1: Build Stage ----
FROM python:3.10-slim as builder

# Install system dependencies required for building mysqlclient
RUN apt-get update && apt-get install -y \
    pkg-config \
    default-libmysqlclient-dev \
    build-essential

WORKDIR /app
COPY requirements.txt .
RUN pip wheel --no-cache-dir --wheel-dir /app/wheels -r requirements.txt


# ---- STAGE 2: Final Stage ----
FROM python:3.10-slim

# --- ALL ROOT ACTIONS FIRST ---
# 1. Install runtime system dependencies as root
RUN apt-get update && apt-get install -y libmariadb3 && rm -rf /var/lib/apt/lists/*

# 2. Create the non-root user and its home directory as root
RUN useradd --create-home --shell /bin/bash appuser

# 3. Copy pre-compiled wheels from the builder stage as root
COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/requirements.txt .

# 4. Install the Python packages into the system's Python site-packages as root
RUN pip install --no-cache-dir --no-index --find-links=/wheels -r requirements.txt

# 5. Set the working directory and copy app code, changing ownership at the same time
WORKDIR /home/appuser/app
COPY --chown=appuser:appuser . .

# --- NOW, SWITCH TO THE NON-ROOT USER ---
# This is one of the last steps. From now on, the container runs as appuser.
USER appuser

# Define the command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]