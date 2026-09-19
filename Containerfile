FROM debian:13-slim

ENV MARZA_HOME="/root/.local/share/marza"
ENV PATH="/root/.local/bin:$MARZA_HOME/bin:$PATH"
WORKDIR /root
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
  --mount=target=/var/cache/apt,type=cache,sharing=locked \
  rm -f /etc/apt/apt.conf.d/docker-clean \
  && apt-get update \
  # GCC is needed with Node 26.
  && apt-get install -y --no-install-recommends curl gcc ca-certificates micro xz-utils
RUN update-ca-certificates
RUN mkdir -p .config .local/bin .local/share .local/state
RUN echo "alias ls='ls -A --group-directories-first'" >> .bashrc

CMD ["sleep", "infinity"]
