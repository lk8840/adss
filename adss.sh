#!/bin/bash

script_path=$(dirname $(readlink -f "$0"))

. ${script_path}/include/dialog.sh

dialog_selectapp_null
