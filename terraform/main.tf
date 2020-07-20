provider "openstack" {

}

resource "openstack_blockstorage_volume_v3" "apache_mirror" {
    name = "apache_mirror"
    size = 175
    volume_type = "lvm"
}

resource "openstack_compute_instance_v2" "asf" {
    name = "asf"
    image_name = "Ubuntu 18.04"
    flavor_name = "m1.large"
    key_pair = "gandalf"
    security_groups = ["default", "ssh"]
}

resource "openstack_compute_volume_attach_v2" "attached" {
  instance_id = openstack_compute_instance_v2.asf.id
  volume_id   = openstack_blockstorage_volume_v3.apache_mirror.id
  device = "/dev/sdc"
}