# terraform-azure-compute-instance
Launch a basic set of resources in Azure for demonstration purposes

## Setup
To complete setup of this module to run in TFE, you will need to create a service principal account.   

First you need to login and pick a subscription to launch  your resources in.   Most of us only have one subscription, but because you may be running several, the first step is manual.   

```
az login
```

Capture the _id_ field in the subscription you want:
```
export ARM_SUBSCRIPTION_ID=<id>
```


Running the create_service_principal.sh script will do the rest for you:
* Create the service account
* Define azure environment variables
  * ARM_CLIENT_ID
  * ARM_CLIENT_SECRET 
  * ARM_TENANT_ID 
* Save all environment variables to an output file

```
./create_service_principal.sh
```

Once the environment has been setup, you can configure your workspaces by running the create_tfe_workspaces.sh

#TODO

## Reference Material
General Azure provider information
https://www.terraform.io/docs/providers/azurerm/

Setting up the Service Principal
https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html



