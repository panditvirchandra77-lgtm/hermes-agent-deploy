FROM python:3.11-slim

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl build-essential && \
    rm -rf /var/lib/apt/lists/*

# Install uv
RUN pip install --no-cache-dir uv

# Clone Hermes Agent
RUN git clone https://github.com/NousResearch/hermes-agent.git /opt/hermes-agent

WORKDIR /opt/hermes-agent

# Create venv and install
RUN uv venv venv --python 3.11 && \
    . venv/bin/activate && \
    uv pip install -e ".[all]"

# Create hermes config directory
RUN mkdir -p /root/.hermes

# Make venv activate on shell entry
ENV PATH="/opt/hermes-agent/venv/bin:$PATH"

# ATXP Connection
ENV ATXP_CONNECTION="https://accounts.atxp.ai?connection_token=D7J1ICmWzYtMSFyv9MTgR"

# Default port for gateway
EXPOSE 8080

# Start gateway
CMD ["hermes", "gateway", "run"]
