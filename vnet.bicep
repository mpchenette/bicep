// =========== vnet.bicep ===========

// USER-PROVIDED PARAMETERS
param environment string
param instance string = '1'

// PROPERTIES PARAMETERS
param vnetAddressPrefixes array = [ '10.0.0.0/16' ]
param addressSpace object = { addressPrefixes: vnetAddressPrefixes }

// BASE PARAMETERS
param name string = 'vnet-${environment}-${location}-${padLeft(instance, 3, '0')}'
param location string = resourceGroup().location
param properties object = { addressSpace: addressSpace }

// RESOURCE
resource vnet 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: name
  location: location
  properties: properties
}

output name string = name
