FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
        curl \
        wget \
        unzip \
        gnupg \
        software-properties-common \
        git \
        && rm -rf /var/lib/apt/lists/*

RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install terraform

RUN curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.19.0/terraform-docs-v0.19.0-$(uname)-amd64.tar.gz \
    &&  tar -xzf terraform-docs.tar.gz \
    &&  chmod +x terraform-docs \
    &&  mv terraform-docs /usr/local/bin/terraform-docs
