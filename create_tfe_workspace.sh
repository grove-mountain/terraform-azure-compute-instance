#!/bin/bash

if [ -z "${TERRAFORM_ENTERPRISE_TOKEN}" ];then
  echo "TERRAFORM_ENTERPRISE_TOKEN is not set, tfe cli will not be able to authenticate"
  echo "Set this to a user token with permissions to create workspaces"
  exit 1
fi

# Load in common environment variables for this repo
. default_env.sh

# Source the service principal environment variables
. ${TFE_ARM_ENV}

# This function will vary by each workspace type.   It's here to allow re-use by environment
# The function does basic wrapping for setting organization, workspace and category but also accepts any other flags like --sensitive or --hcl 
create_variables () {
  # AWS specific variables to create
  CATEGORY=terraform
  create_variable name_prefix ${OWNER}-${ENVIRONMENT}
  create_variable resource_group_location "${REGION}"
  create_variable vn_location "${REGION}"
  create_variable vn_address_space ${VN_ADDRESS_SPACE} --hcl
  create_variable sb_address_prefix ${SB_ADDRESS_PREFIX}
  create_variable vm_size ${INSTANCE_TYPE} 
  create_variable admin_password ${ADMIN_PASSWORD} --sensitive
  create_variable environment_tag ${ENVIRONMENT}
  create_variable owner_tag ${OWNER}
  create_variable ttl_tag ${TTL}
  # Environment variables
  CATEGORY=env
  create_variable ARM_SUBSCRIPTION_ID ${ARM_SUBSCRIPTION_ID}
  create_variable ARM_TENANT_ID ${ARM_TENANT_ID}
  create_variable ARM_CLIENT_ID ${ARM_CLIENT_ID}
  create_variable ARM_CLIENT_SECRET ${ARM_CLIENT_SECRET} --sensitive
  create_variable CONFIRM_DESTROY 1
}

# Load custom environment variables used in this script
. env.sh

# Load any common functions used across cloud scripts
. ../tfe-saas-demo-setup/base_functions.sh

###  Create Azure Workspaces ###
for ENVIRONMENT in ${ENVIRONMENTS};do
  WORKSPACE=${WORKSPACE_PREFIX}-${ENVIRONMENT}
  BRANCH=${ENVIRONMENT}
  # Create the workspace with the variables above
  create_workspace
  create_variables
done
