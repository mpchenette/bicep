// =========== agw.bicep ===========

// USER-PROVIDED PARAMETERS
param application string
param environment string
param instance string = '1'
param vnetName string
param snetName string

@allowed([443, 8080])
param httpSettingPort int = 443
param httpSettingProtocol string = 'Http'


// PROPERTIES PARAMETERS
param sku object = {
  name: 'Standard_Small'
  tier: 'Standard'
  capacity: 2
}
param backendPools array = [
  { name: 'appGatewayBackendPool', properties: { backendAddresses: [ { IpAddress: '10.0.0.4' }, { IpAddress: '10.0.0.5' } ] } }
]
param backendHttpSettings array = [
  { name: 'appGatewayBackendHttpSettings', properties: { port: httpSettingPort, protocol: httpSettingProtocol, cookieBasedAffinity: 'Disabled' } }
]
param httpListeners array = [
  { name: 'appGatewayHttpListener', properties: { frontendIPConfiguration: { id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', name, 'appGatewayFrontendIP') }, frontendPort: { id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', name, 'appGatewayFrontendPort') }, protocol: 'Http' } }
]
param requestRoutingRules array = [
  { name: 'rule1', properties: { ruleType: 'Basic', httpListener: { id: resourceId('Microsoft.Network/applicationGateways/httpListeners', name, 'appGatewayHttpListener') }, backendAddressPool: { id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', name, 'appGatewayBackendPool') }, backendHttpSettings: { id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', name, 'appGatewayBackendHttpSettings') } } }
]
param frontendPorts array = [
  { name: 'appGatewayFrontendPort',  properties: { port: 80 } }
]

// BASE PARAMETERS
param name string = 'agw-${application}-${environment}-${location}-${padLeft(instance, 3, '0')}'
param location string = resourceGroup().location

// DEPENDENCIES
resource vnet 'Microsoft.Network/virtualNetworks@2022-11-01' existing = { name: vnetName }
// resource snet 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' existing = { name: snetName }
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, snetName)


// RESOURCE
resource applicationGateway 'Microsoft.Network/applicationGateways@2022-11-01' = {
  name: name
  location: location
  properties: {
    sku: sku
    gatewayIPConfigurations:       [ { name: 'appGatewayIpConfig',     properties: { subnet: { id: subnetRef } } } ]
    frontendIPConfigurations:      [ { name: 'appGatewayFrontendIP',   properties: { subnet: { id: subnetRef } } } ]
    frontendPorts:                 [for frontendPort in frontendPorts:             { name: frontendPort.name,       properties: frontendPort.properties }]
    backendAddressPools:           [for backendPool in backendPools:               { name: backendPool.name,        properties: backendPool.properties }]
    backendHttpSettingsCollection: [for backendHttpSetting in backendHttpSettings: { name: backendHttpSetting.name, properties: backendHttpSetting.properties }]
    httpListeners:                 [for httpListener in httpListeners:             { name: httpListener.name,       properties: httpListener.properties }]
    requestRoutingRules:           [for requestRoutingRule in requestRoutingRules: { name: requestRoutingRule.name, properties: requestRoutingRule.properties }]
  }
  dependsOn: [ vnet ]
}
