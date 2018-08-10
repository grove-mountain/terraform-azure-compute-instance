# This script assumes 

ARM_SUBSCRIPTION_ID=${1:-${ARM_SUBSCRIPTION_ID}}
ARM_JSON=${2:-${ARM_JSON}}
TFE_ARM_ENV=${3:-${TFE_ARM_ENV}}

# Create the role and save the output
if [ ! -f "${ARM_JSON}" ];then
  mkdir -p $(dirname ${ARM_JSON})
  az ad sp create-for-rbac --role="Contributor" \
    --scopes="/subscriptions/${ARM_SUBSCRIPTION_ID}" > ${ARM_JSON}
  # Hide it
  chmod 0600 ${ARM_JSON}
fi

if [ ! -f "${ARM_JSON}" ];then
  mkdir -p $(dirname ${TFE_ARM_ENV})
  # Parse output from above into environment variables used for TFE
  jq -r '@sh "ARM_TENANT_ID=\(.tenant) ARM_CLIENT_ID=\(.appId) ARM_CLIENT_SECRET=\(.password)"' \
    ~/${ARM_JSON} | tr ' ' '\n' > ${TFE_ARM_ENV}
  # Add in subscription id
  echo "ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID}" >> ${TFE_ARM_ENV}
  # Hide it
  chmod 0600 ${TFE_ARM_ENV}
fi

