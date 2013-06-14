#!/bin/bash

script_path=$(dirname $(readlink -f "$0"))

. ${script_path}/include/*.sh

dialog_selectapp_null
