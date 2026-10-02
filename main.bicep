@description('Target Azure Region')
param location string = resourceGroup().location
@description('Environment tag (dev, test, prod)')
param environment string = 'dev'
var vnetName = 'vnet-hub-${environment}'

//Moduler invocation fo the vnet code 
module networkModule './module/vnet.bicep' = {
  name: 'deploy-vnet-module'
  params: {
    location: location
    vnetName: vnetName
  }
  }

// Storage Account with dynamic naming
var storageName = 'stg\({environment}\){uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'

  }

}

// Outputs exported post-deployment
output vnetID string = networkModule.outputs.vnetId
output appSubnetId string = networkModule.outputs.appSubnetId
output storageAccountName string = storageAccount.name
