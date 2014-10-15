@test "radosgw for test zone is configured" {
  # check that the settings look right
  settings=`cat /etc/ceph/ceph.conf | awk '/^\[/ { $1 ~ /\[client.radosgw.us-test\]/ ? mode=1 : mode=0 } /^ +/ {if (mode==1) print $0;}'`
  test -n "$settings"
  echo "$settings" | grep 'rgw region = default' > /dev/null
  echo "$settings" | grep 'rgw region root pool = .rgw.root' > /dev/null
  echo "$settings" | grep 'rgw zone = default' > /dev/null
  echo "$settings" | grep 'rgw zone root pool = .rgw.root' > /dev/null
  echo "$settings" | grep 'keyring = /etc/ceph/ceph.client.radosgw.us-test.keyring' > /dev/null
  echo "$settings" | grep 'rgw socket path = /var/run/ceph/radosgw.us-test' > /dev/null
  echo "$settings" | grep 'rgw dns name = ceph.test' > /dev/null
  echo "$settings" | grep 'rgw print continue = true' > /dev/null
}

@test "radosgw for test zone has keys" {
  test -e /etc/ceph/ceph.client.radosgw.us-test.keyring
}
@test "radosgw for test zone should start" {
  test -e /var/lib/ceph/radosgw/ceph-radosgw.us-test
}
@test "radosgw for test zone is running" {
  ps -ef | grep 'radosg[w].*radosgw.us-test' > /dev/null
  test -e /var/run/ceph/radosgw.us-test
}

