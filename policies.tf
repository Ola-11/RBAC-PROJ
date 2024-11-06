provider "azurerm" {
  features {}
  version = "~> 5.0"  # Use an updated version for compatibility
}

resource "azurerm_policy_definition" "enforce_tags" {
  name         = "enforce-tags"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Enforce resource tagging"
  description  = "Ensure all resources have the required tags"
  metadata     = jsonencode({
    category = "Tags"
  })
  policy_rule  = jsonencode({
    "if" = {
      "field" = "tags"
      "equals" = {}
    }
    "then" = {
      "effect" = "deny"
    }
  })
}

resource "azurerm_policy_assignment" "assign_tags_policy" {
  name                 = "assign-tags-policy"
  policy_definition_id = azurerm_policy_definition.enforce_tags.id
  scope                = "/subscriptions/${data.azurerm_subscription.primary.id}"
}
