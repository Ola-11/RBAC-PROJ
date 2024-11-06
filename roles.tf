data "azurerm_subscription" "primary" {}

resource "azurerm_role_definition" "reader_role" {
  name        = "Reader"
  scope       = "/subscriptions/${data.azurerm_subscription.primary.id}"
  description = "Can read everything"
  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/subscriptions/read"
    ]
  }
  assignable_scopes = ["/subscriptions/${data.azurerm_subscription.primary.id}"]
}
resource "azurerm_role_assignment" "reader_assignment" {
  principal_id           = "user-or-service-principal-id"
  role_definition_name   = azurerm_role_definition.reader_role.name
  scope                  = "/subscriptions/${data.azurerm_subscription.primary.id}"
}
