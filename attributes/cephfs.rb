default['ceph']['cephfs_mount'] = '/ceph'

case node['platform_family']
when 'debian'
  packages = ['ceph-fs-common', 'ceph-fuse']
  packages += debug_packages(packages) if node['ceph']['install_debug']
  default['ceph']['cephfs']['packages'] = packages
when 'rhel'
  packages = ['ceph-fuse']
  if node['platform'] == 'redhat' && node['platform_version'].to_i >= 7 && node['ceph']['version'] > 'firefly'
    packages << 'kmod-ceph'
  end
  default['ceph']['cephfs']['packages'] = packages
else
  default['ceph']['cephfs']['packages'] = ['ceph-fuse']
end
