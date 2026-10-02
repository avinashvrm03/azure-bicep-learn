@description('Name of Storage Account')
param storageAccountName string
@description('Azure region where the storage account will be deployed')
param location string = resourceGroup().location
@description('Storage Account SKU')
param skuName string = 'Standard_LRS'
@description('Storage Account Kind')
param kind string = 'StorageV2'
@description('Deployment Enviornment')
@allowed([
  'dev'
  'test'
  'prod'
])
param environment string = 'dev'
@description('Owner of the resource')
param owner string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01'={
  name:storageAccountName
  location:location
  sku:{
    name:skuName
  }
  kind:kind
  tags: {
    Environment: environment
    Owner: owner
    ManagedBy: 'Bicep'
  }
  properties:{
    accessTier:'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
  }
}

output storageAccountName string = storageAccount.name
