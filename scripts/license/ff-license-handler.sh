#!/usr/bin/env bash

license_handler() {
  echo -e "\033[34mPut your license file to \033[37m./out/license.lic\033[0m"
  echo -e "\033[34mThen press [ENTER] to continue...\033[0m"
  while [ true ] ; do
    read -t 3 -n 1
    if [ $? = 0 ] && [ -f "./out/license.lic" ] ; then
      break;
    fi
  done
}
