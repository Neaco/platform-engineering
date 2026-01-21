envs = {
    "dev" = {
        name = "dev"
    },
    "stg" = {
        name = "stg"
    },
    "prd" = {
        name = "prd"
    }
}

users = {}

env-groups = {
    contributor-terraform= {
        name = "SEC - %s - Contributor - Terraform"
        descr = "Edition des states %s"
    }
}

admins = {
    "admin.nicolas" = {
        name = "Admin Nicolas Launay"
        user_principal_name = "nicolas@launay.dev"
    }
}


tenant = {
    id = "6dedfb86-8f1a-4d65-a638-a9d895314916"
}

subscription = {
    id="5f7ea694-974f-4988-84d5-67ca26ce6950"
}

tf-storage = {
  resource_group_name = "rg-tfstate"
  name = "stfstate4567"
}

domain_name = "launay.dev"