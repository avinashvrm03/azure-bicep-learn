@description('Name Of the Storage Account')
param storageAccountName string
@description('Azure Region Where Storage Account will be deployed')
param location string = resourceGroup().location
@description('Owner of the resource')
param owner string

module storage './module/storage.bicep'={
  name: 'storageDeployment'
  params:{
    storageAccountName:storageAccountName
    location:location
    owner: owner
  }

}


output storageAccountName string = storage.outputs.storageAccountName
