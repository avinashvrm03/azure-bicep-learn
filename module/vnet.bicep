@description('Azure region for vnet deployment')
param location string
@description('Name Of Virtual Network')
param vnetName string
@description('Address prefixes for the Virtual Network')
param vnetAddressPrefixes array = ['10.0.0.0/16']
@description('Subnet configuration list')
param subnets array = [
  {
    name: 'snet-app'
    subnetPrefix: '10.0.1.0/24'
  }
  {
    name: 'snet-db'
    subnetPrefix: '10.0.2.0/24'
  }
]

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name:vnetName
  location:location
  properties: {
    addressSpace: {
      addressPrefixes:vnetAddressPrefixes
    }
    subnets: [for sub in subnets: {
      name: sub.name 
      properties: {
        addressPrefix:sub.subnetPrefix
      }
    }]
  }
}

// Outputs to pass downstream to other modules or resources
output vnetID string = vnet.Id
output vnetName string = vnet.name
output appSubnetID string = vnet.properties.subnets[0].id
