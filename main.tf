
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = true
}

resource "azurerm_private_endpoint" "acr" {
  name                = "acr-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "acr-priv"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
}
##################################################################################
#                              On l'active pour la WebApp                                    #
##################################################################################

#resource "azurerm_role_assignment" "acrpushassignmentt" {
#  scope                            = azurerm_container_registry.acr.id
#  role_definition_name             = "AcrPush"
#  principal_id                     = azurerm_linux_web_app.app.identity[0].principal_id
#  skip_service_principal_aad_check = true

#}

#resource "azurerm_role_assignment" "acrdeleteassignmentt" {
# scope                            = azurerm_container_registry.acr.id
#role_definition_name             = "AcrDelete"
#principal_id                     = azurerm_linux_web_app.app.identity[0].principal_id
#skip_service_principal_aad_check = true

#}
