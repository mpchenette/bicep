param application string
param environment string
param instance string = '1'

// PROPERTIES PARAMETERS

// BASE PARAMETERS
param name string = 'apim-${application}-${environment}-${padLeft(instance, 3, '0')}'
param location string = resourceGroup().location
param sku object = {
  name: 'Developer'
  capacity: 1
}
param identity object = { type: 'None' }
param properties object = {
  publisherEmail: 'iron3bromate@gmail.com'
  publisherName: 'chenette'
}

resource apim 'Microsoft.ApiManagement/service@2023-03-01-preview' = {
  name: name
  location: location
  sku: sku
  identity: identity
  properties: properties
}
