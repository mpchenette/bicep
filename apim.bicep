param application string
param environment string
param instance string = '1'

// PROPERTIES PARAMETERS

// BASE PARAMETERS
param name string = 'apim-${application}-${environment}-${padLeft(instance, 3, '0')}'
param location string = resourceGroup().location
param sku object = {
  name: 'Standard'
  capacity: 1
}
param identity object = { type: 'None' }
param properties object = {
  publisherEmail: 'iron3bromate@gmail.com'
  publisherName: 'chenette'
  notificationSenderEmail: 'apimgmt-noreply@mail.windowsazure.com'
  hostnameConfigurations: [
    {
      type: 'Proxy'
      hostName: 'apim-chenette'
      negotiateClientCertificate: false
      defaultSslBinding: true
      certificateSource: 'BuiltIn'
    }
  ]
  customProperties: {
    'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'false'
    'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'false'
    'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'false'
    'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'false'
    'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'false'
    'Microsoft.WindowsAzure.ApiManagement.Gateway.Protocols.Server.Http2': 'false'
    'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TripleDes168': 'false'
    'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Ssl30': 'false'
  }
  virtualNetworkType: 'None'
  disableGateway: false
  natGatewayState: 'Unsupported'
  apiVersionConstraint: {}
  publicNetworkAccess: 'Enabled'
  legacyPortalStatus: 'Enabled'
  developerPortalStatus: 'Enabled'
}

resource apim_chenette 'Microsoft.ApiManagement/service@2023-03-01-preview' = {
  name: name
  location: location
  sku: sku
  identity: identity
  properties: properties
}
