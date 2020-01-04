VBoxManage clonehd ubuntu-bionic-18.04-cloudimg.vmdk cloned.vdi --format vdi
VBoxManage modifyhd cloned.vdi --resize 20000
sleep 5
rm -f ubuntu-bionic-18.04-cloudimg.vmdk
VBoxManage clonehd cloned.vdi ubuntu-bionic-18.04-cloudimg.vmdk --format vmdk
rm -f cloned.vdi
