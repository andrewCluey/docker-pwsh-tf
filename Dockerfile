# Alpine image with powershell core and Terraform installed.

FROM mcr.microsoft.com/powershell:7.0.0-preview.6-alpine-3.8 as base

RUN mkdir -p /scripts
WORKDIR /scripts

RUN apk add --no-cache ca-certificates \
            curl \
            git \
            unzip \
            make \
            gcc \
            musl-dev

# Get tflint
RUN curl -L ""$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E ""https://.+?_linux_amd64.zip"")"" -o tflint.zip \
    && unzip tflint.zip \
    && mv tflint /usr/bin/tflint \
    && rm tflint.zip

# Get Terraform
ENV TF_VERSION=0.12.19

RUN curl -sS -L -O https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
	&& unzip terraform_${TF_VERSION}_linux_amd64.zip \
	&& mv terraform /usr/bin/terraform \
	&& chmod +x /usr/bin/terraform

# Build a tiny image
FROM mcr.microsoft.com/powershell:7.0.0-preview.6-alpine-3.8
LABEL \
	maintainer="Andrew Clure" \
    description="Alpine image with powershell Core & terraform" 

COPY --from=base /usr/bin/terraform /usr/bin/terraform

COPY --from=base /usr/bin/tflint /usr/bin/tflint

WORKDIR /scripts

CMD [ "pwsh" ]