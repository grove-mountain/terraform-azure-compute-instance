# Creates an Azure Service Principal, json config and environment variable config files


# Load common environment variables
. default_env.sh

# Date to append to any service principals created
DATE=$(date +%Y-%m-%d-%H-%M-%S)
## DEFAULT VALUES ##
# Default service principal based on the username
ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID:-""}
ARM_SP_PREFIX="${USER}"

usage () {
  cat << EOF
usage: $0 -s <ARM subscription ID> 
         [ -p <Service Principal Name Prefix> ] 

ARM subscription ID is required, can be set with env_var ARM_SUBSCRIPTION_ID
Service Principal Name prefix defaults to \${USER}.  A date string in the format +%Y-%m-%d-%H-%M-%s will be appended to all entries to keep them consistent with the azure CLI names
EOF
exit 0
}

while getopts ":p:s" opt;do
  case ${opt} in
    p) ARM_SP_PREFIX=${OPTARG};;
    s) ARM_SUBSCRIPTION_ID=${OPTARG};;
  esac
done

# Create a name compatible with the azure-cli name format
ARM_SP_NAME="${ARM_SP_PREFIX}-${DATE}"

if [ -z "${ARM_SUBSCRIPTION_ID}" ];then
  usage
fi

# Create the role and save the output
if [ ! -f "${ARM_JSON}" ];then
  mkdir -p $(dirname ${ARM_JSON})
  az ad sp create-for-rbac -n ${ARM_SP_NAME} --role="Contributor" \
    --scopes="/subscriptions/${ARM_SUBSCRIPTION_ID}" > ${ARM_JSON}
  # Hide it
  chmod 0600 ${ARM_JSON}
fi

if [ ! -f "${TFE_ARM_ENV}" ];then
  mkdir -p $(dirname ${TFE_ARM_ENV})
  # Parse output from above into environment variables used for TFE
  jq -r '@sh "ARM_TENANT_ID=\(.tenant) ARM_CLIENT_ID=\(.appId) ARM_CLIENT_SECRET=\(.password)"' \
    ${ARM_JSON} | tr ' ' '\n' > ${TFE_ARM_ENV}
  # Add in subscription id
  echo "ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID}" >> ${TFE_ARM_ENV}
  # Add export to the envs for portability
  sed -i -e 's/^/export /' ${TFE_ARM_ENV}
  # Hide it
  chmod 0600 ${TFE_ARM_ENV}
fi
