// =========== main.bicep ===========

param buildId string
param environment string
param location string = resourceGroup().location



module apim '../../apim.bicep' = {
  name: 'unit-test-${buildId}-apim'
  params: {
    application: 'apimchenette'
    environment: environment
    location: location
  }
}

// module vnet '../../vnet.bicep' = {
//   name: 'unit-test-${buildId}-vnet'
//   params: {
//     environment: environment
//     location: location
//   }
// }

// module snet '../../snet.bicep' = {
//   name: 'unit-test-${buildId}-snet'
//   params: {
//     vnetName: vnet.outputs.name
//     environment: environment
//     location: location
//   }
// }

