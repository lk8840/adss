#!/bin/bash

script_path=$(dirname $(readlink -f "$0"))

. ${script_path}/include/dialog.sh
. ${script_path}/include/config.sh
. ${script_path}/include/general.sh

. ${script_path}/include/proftpdmysql.sh




dialog_selectapp_null

