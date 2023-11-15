param location string

param resourceGroupID string = resourceGroup().id
param suffix string = uniqueString(resourceGroupID)
param storageAccountName string = 'azuredocssa${suffix}'
param cognitiveSearchName string = 'azuredocs-acs-${suffix}'
// param cosmosDbName string = 'azuredocs-cbd-${suffix}'
// param databaseName string = 'azuredocs-db'
// param amlWorkspaceName string = 'azuredocs-mlw-${suffix}'

output storageAccountName string = storageAccount.name

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    minimumTlsVersion: 'TLS1_2'
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    isHnsEnabled: false
  }
}

resource cognitiveSearch 'Microsoft.Search/searchServices@2020-08-01' = {
  name: cognitiveSearchName
  location: location
  sku: {
    name: 'standard'
  }
  properties: {
    hostingMode: 'default'
    partitionCount: 1
    replicaCount: 1
    publicNetworkAccess: 'enabled'
  }
}

// resource cosmosDB 'Microsoft.DocumentDB/databaseAccounts@2021-05-15' = {
//   name: cosmosDbName
//   location: location
//   kind: 'GlobalDocumentDB'
//   properties: {
//     databaseAccountOfferType: 'Standard'
//     locations: [
//       {
//         locationName: location
//         failoverPriority: 0
//         isZoneRedundant: false
//       }
//     ]
//     enableMultipleWriteLocations: false
//     isVirtualNetworkFilterEnabled: false
//     enableFreeTier: false
//     enableAnalyticalStorage: false
//     publicNetworkAccess: 'Enabled'
//     keyVaultKeyUri: ''
//     enableAutomaticFailover: false
//     enableCassandraConnector: false
//     connectorOffer: ''
//     disableKeyBasedMetadataWriteAccess: false
//   }
// }

// resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2022-05-15' = {
//   parent: cosmosDB
//   name: databaseName
//   properties: {
//     resource: {
//       id: databaseName
//     }
//   }
// }

// resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2022-05-15' = {
//   parent: database
//   name: 'chat'
//   properties: {
//     resource: {
//       id: 'chat'
//       partitionKey: {
//         paths: [
//           '/chatId'
//         ]
//         kind: 'Hash'
//       }
//     }
//   }
// }

// resource mlWorkspace 'Microsoft.MachineLearningServices/workspaces@2021-07-01' = {
//   name: amlWorkspaceName
//   location: location
//   identity: {
//     type: 'SystemAssigned'
//   }
//   sku: {
//     name: 'Basic'
//   }
//   properties: {
//     friendlyName: amlWorkspaceName
//     description: 'Machine Learning Workspace for Chat with Azure Docs'
//     storageAccount: workspaceStorageAccount.id
//   }
// }

// resource workspaceStorageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
//   name: storageAccountName
//   location: location
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
// }
