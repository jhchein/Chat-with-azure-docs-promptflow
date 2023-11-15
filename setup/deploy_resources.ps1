# Define parameters
$subscritionName = "<your-subscription-name>" # UPDATE THIS VALUE!
$location = "<select-a-location>" # UPDATE THIS VALUE!
$resourceGroupName = "chat-with-azure-docs-rg"

# Login to Azure
az login --output none

# Select the subscription
az account set --subscription $subscritionName

# Create the resource group
az group create -l $location -n $resourceGroupName

# Deploy the Bicep file
az deployment group create --name MyDeployment --resource-group $resourceGroupName --template-file "main.bicep" --parameters location=$location
# Get the storage account name
$storageAccountName = az deployment group show --name MyDeployment --resource-group $resourceGroupName --query 'properties.outputs.storageAccountName.value' -o tsv

# Create a service principal
$servicePrincipal = az ad sp create-for-rbac --name "chat-with-azure-docs-sp" --sdk-auth | ConvertFrom-Json

# # Assign the "Storage Blob Data Contributor" role to the service principal
$storageAccountId = az storage account show --name $storageAccountName --resource-group $resourceGroupName --query id -o tsv
az role assignment create --assignee $servicePrincipal.clientId --role "Storage Blob Data Contributor" --scope $storageAccountId

# Set the service principal credentials and storage account details as secrets in the GitHub repository
gh secret set AZURE_CREDENTIALS --body="`"$($servicePrincipal | ConvertTo-Json)`""
gh secret set STORAGE_ACCOUNT_NAME --body="$storageAccountName"
gh secret set STORAGE_ACCOUNT_ID --body="$storageAccountId"

# Logout of Azure
az logout