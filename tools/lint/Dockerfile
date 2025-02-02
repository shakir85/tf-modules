# Use Ubuntu as the base image
FROM ubuntu:latest

# Set non-interactive mode to prevent prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    gnupg \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform CLI
RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install terraform

# Install TFLint (Terraform Linter)
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

COPY tflint.sh /app/
WORKDIR /app

CMD [ "tflint.sh" ]