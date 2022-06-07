#!/usr/bin/env bash

hypervisor_handler() {
  echo
  echo -e "\033[34mSetting up ESXi connection...\033[0m"
  echo -e "Leave blank and press [ENTER] to use default values if provided"
  echo -e "All fields are required except default values had been provided"
  read -p "$(echo -ne '\033[34mEnter your ESXi server IP: \033[0m')" HYPERVISOR_HOST
  read -p "$(echo -ne '\033[34mEnter your ESXi user (default is "root"): \033[0m')" HYPERVISOR_USER
  read -p "$(echo -ne '\033[34mEnter your ESXi password: \033[0m')" HYPERVISOR_PASSWORD
  echo

  export HYPERVISOR_HOST
  export HYPERVISOR_USER=${HYPERVISOR_USER:-root}
  export HYPERVISOR_PASSWORD

  hypervisor_test;
}

hypervisor_test() {
  echo
  echo -ne "\033[34mEstablish ESXi connection checking...\033[0m"
  while [ true ] ; do
    sshpass -p $HYPERVISOR_PASSWORD ssh -o "ConnectTimeout=10" -o "StrictHostKeyChecking=no" -q $HYPERVISOR_USER@$HYPERVISOR_HOST exit
    if [ $? = 0 ] ; then
      echo -e "\033[32mSUCCEEDED\033[0m"
      break;
    else
      echo -e "\033[31mESXi connection failed!\033[0m"
      echo -e "\033[34mPlease check your connection and try again.\033[0m"
      echo -e "\033[34mThen press [ENTER] to continue...\033[0m"
      hypervisor_handler;
      break;
    fi
  done
}

vm_handler() {
  echo -e "\033[34mSetting up VM(s)...\033[0m"
  echo -e "Leave blank and press [ENTER] to use default values if provided"
  echo -e "All fields are required except default values had been provided"
  read -p "$(echo -ne '\033[34mEnter your ESXi Datastore (default is "datastore1"): \033[0m')" HYPERVISOR_DATASTORE
  read -p "$(echo -ne '\033[34mEnter target Port Group for VM(s):\n  (default is "VM Network"): \033[0m')" VM_IP_GROUP
  read -p "$(echo -ne '\033[34mEnter target Gateway for VM(s): \033[0m')" VM_GATEWAY
  read -p "$(echo -ne '\033[34mEnter target DNS for VM(s): \033[0m')" VM_NS
  read -p "$(echo -ne '\033[34mEnter IP for VM "ArgusHack-DB":\n  (IPv4, MUST be formated in CIDR, ex: 10.120.2.1/16): \033[0m')" VM_DB_IP
  read -p "$(echo -ne '\033[34mEnter IP for VM "ArgusHack-Server-M01"\n  (IPv4, MUST be formated in CIDR, ex: 10.120.2.2/16): \033[0m')" VM_SERVER_IP
  echo

  export HYPERVISOR_DATASTORE=${HYPERVISOR_DATASTORE:-datastore1}
  export VM_IP_GROUP=${VM_IP_GROUP:-VM Network}
  export VM_GATEWAY
  export VM_NS
  export VM_DB_IP
  export VM_SERVER_IP

  vm_test;
}

vm_test() {
  echo -ne "\033[34mVM(s) setup Confirmation\033[0m"
  while [ true ] ; do
    echo -e "\033[34mESXi Datastore: \033[0m$HYPERVISOR_DATASTORE"
    echo -e "\033[34mVM(s) Port Group: \033[0m$VM_IP_GROUP"
    echo -e "\033[34mVM(s) Gateway: \033[0m$VM_GATEWAY"
    echo -e "\033[34mVM(s) DNS: \033[0m$VM_NS"
    echo -e "\033[34mVM: ArgusHack-DB IP: \033[0m$VM_DB_IP"
    echo -e "\033[34mVM: ArgusHack-Server-M01 IP: \033[0m$VM_SERVER_IP"
    echo -ne "\033[34mIs this correct? \033[0m"
    read -p "(Y/n):" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]] ; then
      echo -e "\033[34mApply VM(s) configuration...\033[0m"

      export VM_DB_IP_GROUP=$VM_IP_GROUP
      export VM_DB_GATEWAY=$VM_GATEWAY
      export VM_DB_NS=$VM_NS
      export VM_SERVER_IP_GROUP=$VM_IP_GROUP
      export VM_SERVER_GATEWAY=$VM_GATEWAY
      export VM_SERVER_NS=$VM_NS

      break;
    else
      echo -e "\033[31mApply VM(s) configuration...\033[31mFAILED\033[0m"
      echo -e "\033[34mUser asked to modify VM(s) configuration\033[0m"
      vm_handler;
      break;
    fi
  done
}

hypervisor_handler;
vm_handler;

echo $(cat <<EOF
{
  "HYPERVISOR_HOST": "$HYPERVISOR_HOST",
  "HYPERVISOR_USER": "$HYPERVISOR_USER",
  "HYPERVISOR_PASSWORD": "$HYPERVISOR_PASSWORD",
  "HYPERVISOR_DATASTORE": "$HYPERVISOR_DATASTORE",
  "VM_DB_IP": "$VM_DB_IP",
  "VM_DB_IP_GROUP": "$VM_DB_IP_GROUP",
  "VM_DB_GATEWAY": "$VM_DB_GATEWAY",
  "VM_DB_NS": "$VM_DB_NS",
  "VM_DB_PASSWORD": "$SECRET_VM_PASSWORD",
  "VM_DB_PASSWORD_ENCRYPTED": "$SECRET_VM_PASSWORD_ENCRYPTED",
  "VM_SERVER_IP": "$VM_SERVER_IP",
  "VM_SERVER_IP_GROUP": "$VM_SERVER_IP_GROUP",
  "VM_SERVER_GATEWAY": "$VM_SERVER_GATEWAY",
  "VM_SERVER_NS": "$VM_SERVER_NS",
  "VM_SERVER_PASSWORD": "$SECRET_VM_PASSWORD",
  "VM_SERVER_PASSWORD_ENCRYPTED": "$SECRET_VM_PASSWORD_ENCRYPTED",
}
EOF
) > ./out/config.json
