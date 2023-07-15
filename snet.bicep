// =========== snet.bicep ===========

// USER-PROVIDED PARAMETERS
param environment string
param instance string = '1'
param vnetName string

// PROPERTIES PARAMETERS
param subnetAddressPrefix string = '10.0.0.0/24'
param location string = resourceGroup().location

// BASE PARAMETERS
param name string = 'snet-${environment}-${location}-${padLeft(instance, 3, '0')}'
resource parent 'Microsoft.Network/virtualNetworks@2022-11-01' existing = { name: vnetName }
param properties object = { addressPrefix: subnetAddressPrefix }

// RESOURCE
resource snet 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  name: name
  parent: parent
  properties: properties
}

output name string = name
