// https://docs.microsoft.com/en-us/azure/templates/microsoft.management/managementgroups?tabs=bicep

resource symbolicname 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'chenette'
  scope: tenant()
}
