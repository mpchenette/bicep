// https://docs.microsoft.com/en-us/azure/templates/microsoft.management/managementgroups?tabs=bicep

targetScope = 'managementGroup'

resource symbolicname 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'chenette'
  scope: tenant()
}

resource symbolicname2 'Microsoft.Management/managementGroups/subscriptions@2021-04-01' = {
  name: 'Azure subscription 1'
  parent: symbolicname
}


// var spokeSubscriptionName = 'Test Sub'
// resource spokeSubscription 'Microsoft.Subscription/aliases@2020-09-01' = {
//   scope: managementGroup('chenette')
//   name: guid(spokeSubscriptionName, tenant().tenantId)
//   properties: {
//     displayName: spokeSubscriptionName
//     billingScope: '/providers/Microsoft.Billing/billingAccounts/9326df79-73cf-5dc2-b11f-fa0374fbe18d:8d1b61cf-7492-4004-a6c7-ff8b4e5ff74d_2019-05-31'
//     workload: 'Production'
//   }
// }
