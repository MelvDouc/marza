FROM debian:13-slim

# Set up environment
ENV MARZA_HOME="/root/.local/share/marza"
ENV PATH="/root/.local/bin:$MARZA_HOME/bin:$PATH"

# Install dependencies
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
  --mount=target=/var/cache/apt,type=cache,sharing=locked \
  rm -f /etc/apt/apt.conf.d/docker-clean \
  && apt-get update \
  # GCC is needed with Node 26.
  && apt-get install -y --no-install-recommends curl gcc git ca-certificates xz-utils

# Fix certificate issue in container
RUN update-ca-certificates

# Prepare user's directory
WORKDIR /root
RUN mkdir -p .config .local/bin .local/share .local/state
COPY src/marza .local/bin/

# Set up bats for testing
RUN git clone --depth 1 https://github.com/bats-core/bats-core.git /tmp/bats-core \
  && /tmp/bats-core/install.sh /usr/local \
  && rm -rf /tmp/bats-core
COPY tests ./tests

ENTRYPOINT [ "/usr/local/bin/bats", "/root/tests/marza.bats" ]
