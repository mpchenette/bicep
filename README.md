## Best Practices
- [Bicep Parameters](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/best-practices#parameters)
- [ARM Templates](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/best-practices)

- It is recommended to give a descriptive and unique [deploymentName](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/azure-resource-manager-template-deployment-v3?view=azure-pipelines#inputs) for both the modules used and for the Azure Pipelines task itself. This allows for quicker and easier debugging of potential errors.

- https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/best-practices#parameters

- The idea is to be able to delete the entire application in Azure and be able to redeploy it with one click of a button

- One thing that IaC does not address is data.


- The principal behind these templates:
  - They can be deployed with only 1-2 parameters required from the consumer
  - Further configuration/customization possible, but not necessary

- The idea is also to have these templates have all minimum and recommended security settings enabled by default (i.e., https/tls 1.2, ...)