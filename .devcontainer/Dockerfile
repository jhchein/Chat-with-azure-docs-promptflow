# Use a base image that includes PowerShell
FROM mcr.microsoft.com/azure-powershell

# Install necessary tools
RUN apt-get update && apt-get install -y curl gnupg software-properties-common

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
RUN apt-get update -qq
RUN apt-get install -y -qq gh

# Install Bicep CLI
RUN az bicep install