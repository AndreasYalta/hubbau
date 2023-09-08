targetScope = 'subscription'

param location string
param tags object
param tenantId string
param resourceGroupName string

// 1. RG

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// 2. Keyvault

param resourcePrefix string = 'hubbau'
param keyVaultName string = '${resourcePrefix}${uniqueString(tenantId)}kv'
@secure()
param dbuser string
@secure()
param dbpassword string
@secure()
param token string
param objectId string

module keyVault './keyvault.bicep' = {
  name: 'keyVault'
  scope: rg
  params: {
    keyVaultName: keyVaultName
    location: location
    tags: tags
    tenantId: tenantId
    objectId: objectId
    dbuser: dbuser
    dbpassword: dbpassword
    token: token
  }
}
