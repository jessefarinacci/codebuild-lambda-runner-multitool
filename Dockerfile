FROM public.ecr.aws/docker/library/ubuntu:26.04

ARG DEBIAN_FRONTEND="noninteractive"

COPY rootfs /

RUN set -ex \
  # phase 0
  && echo "setup packages" \
  && (chown -R root:root /etc/apt) \
  && (chmod 0755 /etc/apt/keyrings   /etc/apt/packages   /etc/apt/sources.list.d)   \
  && (chmod 0644 /etc/apt/keyrings/* /etc/apt/packages/* /etc/apt/sources.list.d/*) \
  && echo "all done!"
RUN set -ex \
  # phase 1
  && echo "installing base" \
  && apt-get update \
  && apt-get install --assume-yes apt-transport-https ca-certificates gnupg \
  && echo "all done!" \
  # phase 2
  && echo "installing system" \
  && apt-get update \
  && apt-get install --assume-yes \
  codebuild-lambda-runner-core \
  codebuild-lambda-runner-lang-c \
  codebuild-lambda-runner-lang-dotnet \
  codebuild-lambda-runner-lang-go \
  codebuild-lambda-runner-lang-java \
  codebuild-lambda-runner-lang-javascript \
  codebuild-lambda-runner-lang-lua \
  codebuild-lambda-runner-lang-perl \
  codebuild-lambda-runner-lang-php \
  codebuild-lambda-runner-lang-python \
  codebuild-lambda-runner-lang-ruby \
  codebuild-lambda-runner-lang-rust \
  codebuild-lambda-runner-lang-tcl \
  codebuild-lambda-runner-tool-aws \
  codebuild-lambda-runner-tool-iac \
  codebuild-lambda-runner-tool-ide \
  codebuild-lambda-runner-tool-oci \
  codebuild-lambda-runner-tool-scm \
  codebuild-lambda-runner-tool-web \
  && echo "all done!" \
  # phase 3
  && echo "clean up" \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists \
  # all done!
  && echo "all done!"

USER ubuntu
ENV HOME=/home/ubuntu
