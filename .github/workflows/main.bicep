// =========== main.bicep ===========

param buildId string
param environment string
param location string = resourceGroup().location



module vnet '../../vnet.bicep' = {
  name: 'unit-test-${buildId}-vnet'
  params: {
    environment: environment
    location: location
  }
}

module snet '../../snet.bicep' = {
  name: 'unit-test-${buildId}-snet'
  params: {
    vnetName: vnet.outputs.name
    environment: environment
    location: location
  }
}

