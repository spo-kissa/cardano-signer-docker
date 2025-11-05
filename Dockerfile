FROM ubuntu:jammy

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG TARGETARCH

# Cardano-Singer
ENV CS_VERSION=1.27.0

# cardano-signer
RUN <<'EOF'
set -eux

apt-get update
apt-get install -y gpg curl wget tmux vim jq bash

case "${TARGETARCH:-}" in
  amd64) CS_ARCH="x64" ;;
  arm64) CS_ARCH="arm64" ;;
  *) echo "unsupported TARGETARCH: ${TARGETARCH:-<empty>}" >&2; exit 1 ;;
esac
mkdir $HOME/git
cd $HOME/git
wget -q https://github.com/gitmachtl/cardano-signer/releases/download/v${CS_VERSION}/cardano-signer-${CS_VERSION}_linux-${CS_ARCH}.tar.gz
tar -xzvf cardano-signer-${CS_VERSION}_linux-${CS_ARCH}.tar.gz
rm cardano-signer-${CS_VERSION}_linux-${CS_ARCH}.tar.gz
install -m 0755 ./cardano-signer /usr/local/bin/cardano-signer
rm -rf $HOME/git
echo Cardano-Signer Installed!
cardano-signer --version
sleep 5


EOF

COPY sign.sh /usr/local/bin/sign.sh
RUN chmod 755 /usr/local/bin/sign.sh

USER root
WORKDIR /root

ENTRYPOINT ["tail", "-F", "/dev/null"]
