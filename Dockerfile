FROM python:3.11-slim

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl build-essential && \
    rm -rf /var/lib/apt/lists/*

# Install Hermes Agent
RUN pip install --no-cache-dir hermes-agent

# Create hermes config directory
RUN mkdir -p /root/.hermes

# Default port
EXPOSE 8080

# Start command - can be overridden
CMD ["hermes", "status"]
