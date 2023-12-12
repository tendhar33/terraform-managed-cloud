# Copyright 2023 StreamNative, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

provider "azurerm" {
  features {

  }
}

provider "azuread" {

}

module "azure-sn-cloud-manager" {
  source = "../../modules/azure/sn-cloud-manager"

  resource_group_location = "westus2"
  streamnative_org_id     = "streamnative"
}


module "azure-managed-cloud" {
  source = "../../modules/azure/vendor-access"

  resource_group_name     = "azure-westus2-aks-test"
  resource_group_location = "westus2"

  streamnative_org_id        = "streamnative"
  sn_automation_client_id    = module.azure-sn-cloud-manager.sn_automation_client_id
  sn_support_client_id       = module.azure-sn-cloud-manager.sn_support_client_id
  sn_automation_principal_id = module.azure-sn-cloud-manager.sn_automation_principal_id
  sn_support_principal_id    = module.azure-sn-cloud-manager.sn_support_principal_id

  depends_on = [module.azure-sn-cloud-manager]
}


output "additional_roles" {
  value       = module.azure-managed-cloud.additional_roles
  description = "The additional roles created by this module"
}

output "resource_group_name" {
  value       = module.azure-managed-cloud.resource_group_name
  description = "The name of the resource group where the AKS cluster will be created"
}

output "streamnative_org_id" {
  value       = module.azure-managed-cloud.streamnative_org_id
  description = "An external ID that correspond to your Organization within StreamNative Cloud, used for all managed identities created by the module. This will be the organization ID in the StreamNative console, e.g. \"o-xhopj\"."
}

output "sn_support_principal_id" {
  value       = module.azure-managed-cloud.sn_support_principal_id
  description = "The principal ID of the sn support service principal for StreamNative Cloud support access"
}

output "sn_automation_principal_id" {
  value       = module.azure-managed-cloud.sn_automation_principal_id
  description = "The principal ID of the sn support service principal for StreamNative Cloud support access"
}

output "sn_automation_client_id" {
  value       = module.azure-managed-cloud.sn_automation_client_id
  description = "The client ID of the sn automation service principal for StreamNative Cloud automation"
}

output "sn_support_client_id" {
  value       = module.azure-managed-cloud.sn_support_client_id
  description = "The client ID of the sn support service principal for StreamNative Cloud support access"
}

output "subscription_id" {
  value       = module.azure-managed-cloud.subscription_id
  description = "The subscription ID of the AKS cluster"
}

output "tenant_id" {
  value       = module.azure-managed-cloud.tenant_id
  description = "The tenant ID of the AKS cluster"
}
