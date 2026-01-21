# How to setup
- Go to the Azure portal
- Create a storage account in a rg called "rg-tfstate"
- Create a container "tfstate-admin"
- Add yourself as a "Storage Blob Data Contributor" on that container
- From there, apply  the admin plane


# Environments
- There is one root stack, state, identity ruleset and resource group per environment
- Modules and stacks may be shared
- We will use module version bumps for promotion
- CI affecting prod will require additional validation and have additional identity guardrails