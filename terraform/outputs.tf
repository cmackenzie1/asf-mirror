output "instance_ip_addr" {
    value = openstack_compute_instance_v2.asf.network.*.fixed_ip_v6
}