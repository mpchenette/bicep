// https://docs.microsoft.com/en-us/azure/templates/microsoft.management/managementgroups?tabs=bicep

resource symbolicname 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'chenette'
  scope: tenant()
}

resource symbolicname2 'Microsoft.Management/managementGroups/subscriptions@2021-04-01' = {
  name: 'biceptest'
  parent: symbolicname
}
