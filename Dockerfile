FROM public.ecr.aws/docker/library/ubuntu:resolute

ARG DEBIAN_FRONTEND="noninteractive"

COPY rootfs /

RUN set -ex \
  && echo "fixing perms" \
  # && chmod 644 /etc/apt/apt.conf.d/99use-gzip-compression \
  && chmod 644 /etc/apt/keyrings/opentofu-repo.gpg \
  && chmod 644 /etc/apt/keyrings/opentofu.gpg \
  && chmod 644 /etc/apt/sources.list.d/opentofu.list \
  && find /etc/apt | sort \
  && echo "installing base" \
  && apt-get update \
  && echo "installing tools" \
  && apt-get install --assume-yes --no-install-recommends \
  amazon-ecr-credential-helper \
  apt-transport-https \
  awscli \
  ca-certificates \
  curl \
  docker.io \
  # dotnet-sdk-10.0 \
  hugo \
  gcc \
  git \
  gnupg2 \
  golang \
  make \
  nodejs \
  npm \
  # openjdk-21-jdk \
  openssh-client \
  # perl \
  podman \
  # python3 \
  # python3-pip \
  # rustc-1.91 \
  rsync \
  sed \
  wget \
  && echo "clean up" \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists \
  && echo "done"
