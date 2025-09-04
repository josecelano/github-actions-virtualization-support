# Output information about the VM
output "vm_info" {
  description = "Information about the created VM"
  value = {
    name       = lxd_instance.test_vm.name
    image      = lxd_instance.test_vm.image
    status     = lxd_instance.test_vm.status
    ip_address = lxd_instance.test_vm.ipv4_address
  }
  depends_on = [lxd_instance.test_vm]
}

output "connection_commands" {
  description = "Commands to connect to the VM"
  value = [
    "lxc exec ${var.vm_name} -- /bin/bash",
    "lxc exec ${var.vm_name} -- whoami",
    "lxc list ${var.vm_name}"
  ]
}

output "test_commands" {
  description = "Commands to test the VM functionality"
  value = [
    "lxc exec ${var.vm_name} -- cat /etc/os-release",
    "lxc exec ${var.vm_name} -- cloud-init status",
    "lxc exec ${var.vm_name} -- systemctl status ssh"
  ]
}
