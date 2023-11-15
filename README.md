# Getting Started

This project uses Azure resources, which need to be deployed before you can use the application. Follow these steps to set up your own instance of the project:

1. **Fork the Repository**: Click the "Fork" button at the top right of this page. This creates your own copy of the repository where you can make changes without affecting the original project.

2. **Open in Codespaces**: Go to your forked repository and click the "Code" button, then select "Open with Codespaces" and create a new Codespace. This will open Visual Studio Code in your browser, and the necessary development tools (Azure CLI, GitHub CLI, and Bicep CLI) will be automatically installed.

3. **Log in to Azure**: Open a terminal in Visual Studio Code (View -> Terminal), then run `az login` and follow the instructions to log in to your Azure account.

4. **Run the Deployment Script**: In the terminal, navigate to the `setup` directory and run `pwsh ./deploy_resources.ps1`. This script deploys the necessary Azure resources, creates a service principal, assigns the "Storage Blob Data Contributor" role to the service principal, and sets the service principal credentials and storage account details as secrets in your GitHub repository. Remember to replace the placeholder values in the `deploy_resources.ps1` script with your actual values before running it.

5. **Check the GitHub Secrets**: Go to the "Settings" tab of your forked repository, then click on "Secrets". You should see the `AZURE_CREDENTIALS`, `STORAGE_ACCOUNT_NAME`, and `STORAGE_ACCOUNT_ID` secrets. These are used by the GitHub Actions workflows in the repository.

6. **Run the Application**: You're now ready to run the application. Follow the instructions in the [Running the Application](#running-the-application) section.

## Running the Application

(Add instructions for running the application here)
