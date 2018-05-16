[![Build Status](https://travis-ci.org/cdelgehier/ansible-role-XtraDB-Cluster.svg?branch=master)](https://travis-ci.org/cdelgehier/ansible-role-XtraDB-Cluster)
# Ansible role `ansible-role-XtraDB-Cluster`

An Ansible role for setup a percon XtraDB Cluster. Specifically, the responsibilities of this role are to:

- install packages
- secure connections
- bootstrap the cluster

## Requirements

No specific requirements

## Role Variables

### BASICS
| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `xtradb_bind_address` | - | The listening IP |
| `xtradb_bind_interface` | `eth0` | The interface used by the cluster |
| `xtradb_cluster_name` | `foo` | A name for the cluster |
| `xtradb_configured` | `xtradb_datadir`/configured | A cookie for idempotency |
| `xtradb_datadir` | `/var/lib/mysql` | Directory of data |
| `xtradb_master_node` | `groups[xtradb_nodes_group][0]` | The chosen node to be master |
| `xtradb_mysql_user` | `mysql` | The user for run galera |
| `xtradb_nodes_group` | `xtradb-cluster-nodes` | Node group where the cluster will be installed |
| `xtradb_root_password` | `root` | Password for the root user |
| `xtradb_root_user` | `root` | The root user |
| `xtradb_secured` | `xtradb_datadir`/secured |A cookie for idempotency |
| `xtradb_service` | `mysql` | Linux service name  |
| `xtradb_sst_password` | `sstpassword` | Password for the `xtradb_sst_user` |
| `xtradb_sst_user` | `sstuser` | User used to the state snapshot transfer  |
| `xtradb_swappiness` | `0` | "Swappiness" value. System default is 60. A value of 0 means that swapping out processes is avoided.  |
| `xtradb_databases`     | []          | List of names of the databases to be added                                                                  |
| `xtradb_users`         | []          | List of dicts specifying the users to be added. See below for details.                                      |
| `xtradb_version` | `57` | Package version of XtraDB |

### MySQL part
For more info on the values, read the [MariaDB Server System Variables documentation](https://mariadb.com/kb/en/mariadb/server-system-variables/).


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `xtradb_binlog_format` | `ROW` | The binary logging format  |
| `xtradb_character_set_server` | `utf` | The character set |
| `xtradb_collation_server` | `utf8_general_ci` | The collation |
| `xtradb_default_storage_engine` | `InnoDB` | Setting the Storage Engine |
| `xtradb_innodb_autoinc_lock_mode` | `2` | There are three possible settings for the innodb_autoinc_lock_mode configuration parameter. The settings are 0, 1, or 2, for “traditional”, “consecutive”, or “interleaved” lock mode, respectively |
| `xtradb_innodb_buffer_pool_instances` | ` ` | To enable multiple buffer pool instances, set the innodb_buffer_pool_instances configuration option to a value greater than 1 (8 is the default) up to 64 (the maximum). This option takes effect only when you set innodb_buffer_pool_size to a size of 1GB or more. The total size you specify is divided among all the buffer pools |
| `xtradb_innodb_buffer_pool_size` | ` ` | A good value is 70%-80% of available memory. |
| `xtradb_innodb_file_format` | ` ` |  |
| `xtradb_innodb_file_format_check` | ` ` |  |
| `xtradb_innodb_file_per_table` | ` ` |  |
| `xtradb_innodb_flush_log_at_trx_commit` | ` ` | When innodb_flush_log_at_trx_commit is set to 1 the log buffer is flushed on every transaction commit to the log file on disk and provides maximum data integrity but it also has performance impact. Setting it to 2 means log buffer is flushed to OS file cache on every transaction commit. The implication of 2 is optimal and improve performance if you are not concerning ACID and can lose transactions for last second or two in case of OS crashes.  |
| `xtradb_innodb_log_buffer_size` | ` ` | Innodb writes changed data record into lt’s log buffer, which kept in memory and it saves disk I/O for large transactions as it not need to write the log of changes to disk before transaction commit. 4 MB – 8 MB is good start unless you write a lot of huge blobs |
| `xtradb_innodb_log_file_size` | ` ` |  Default value has been changed in MySQL 5.6 to 50 MB from 5 MB (old default), but it’s still too small size for many workloads |
| `xtradb_innodb_file_per_table` | `on` | innodb_file_per_table is ON by default from MySQL 5.6. This is usually recommended as it avoids having a huge shared tablespace and as it allows you to reclaim space when you drop or truncate a table. Separate tablespace also benefits for Xtrabackup partial backup scheme |
| `xtradb_innodb_strict_mode` | `on` |  |
| `xtradb_join_buffer_size` | ` ` |  |
| `xtradb_log_warnings` | ` ` |  |
| `xtradb_log_warnings` | ` ` |  |
| `xtradb_long_query_time` | ` ` |  |
| `xtradb_max_allowed_packet` | ` ` |  |
| `xtradb_max_connections` | `4096` |  |
| `xtradb_max_heap_table_size` | ` ` |  |
| `xtradb_max_user_connections` | ` ` |  |
| `xtradb_pxc_strict_mode` | `ENFORCING` | PXC Strict Mode is designed to avoid the use of experimental and unsupported features in Percona XtraDB Cluster |
| `xtradb_query_cache_size` | ` ` |  |
| `xtradb_read_buffer_size` | ` ` |  |
| `xtradb_read_rnd_buffer_size` | ` ` |  |
| `xtradb_skip_name_resolve` | `1` | Use IP addresses only. Set to 0 to resolve host names. |
| `xtradb_slow_query_log` | `0` | Set to 1 to enable the slow query log. |
| `xtradb_socket` | ` ` |  |
| `xtradb_sort_buffer_size` | ` ` |  |
| `xtradb_table_definition_cache` | ` ` |  |
| `xtradb_table_open_cache` | ` ` |  |
| `xtradb_table_open_cache_instances` | ` ` |  |
| `xtradb_tmp_table_size` | ` ` |  |

### Adding databases

Databases are defined with a dict containing the fields `name:` (required), and `init_script:` (optional).
The init script is a SQL file that is executed when the database is created to initialise tables and populate it with values.

```yaml
xtradb_databases:
  - name: keystone
  - name: mydb
    init_script: files/init_mydb.sql
```

### Adding users

Users are defined with a dict containing fields `name:`, `password:`, `priv:`, and, optionally, `host:`.
The password is in plain text and `priv:` specifies the privileges for this user as described in the [Ansible documentation](http://docs.ansible.com/mysql_user_module.html).

An example:

```yaml
xtradb_users:
  - name: keystone
    password: KEYSTONE_DBPASS
    priv: 'keystone.*:SUPER'

  - name: cdelgehier
    password: yolo
    priv: 'mydb.*:ALL'
    host: '192.168.1.%'
```


## Dependencies

No dependencies.

## Example Playbook

```yaml
- hosts: db
  gather_facts: true
  become: true
  roles:
    - role: ansible-role-XtraDB-Cluster
      xtradb_cluster_name: "prod-customer"
      xtradb_sst_user: sstuser
      xtradb_sst_password: s3cr3t
      xtradb_root_password: yolo

      xtradb_nodes_group: "db"
      xtradb_bind_interface: eth0
```

```yaml
- hosts: db
  gather_facts: true
  become: true
  roles:
    - role: ansible-role-XtraDB-Cluster
      xtradb_cluster_name: "prod-customer"
      xtradb_sst_user: sstuser
      xtradb_sst_password: s3cr3t
      xtradb_root_password: yolo

      xtradb_bind_address: "{{ ansible_default_ipv4.address }}"
      xtradb_wsrep_cluster_address: "gcomm://{{ groups['db'] | map('extract', hostvars, ['ansible_default_ipv4', 'address']) | join(',') }}"
      xtradb_master_node: "{{ hostvars[ groups['db'][0] ].ansible_default_ipv4.address }}"

```

```yaml
- hosts: db
  gather_facts: true
  become: true
  roles:
    - role: ansible-role-XtraDB-Cluster
      xtradb_cluster_name: "prod-customer"
      xtradb_sst_password: s3cr3t
      xtradb_root_password: yolo
      xtradb_nodes_group: "db"
      xtradb_bind_interface: eth0

      xtradb_databases:
        - name: keystone
      xtradb_users:
        - name: keystone
          password: PASSWD
          priv: 'keystone.*:GRANT,ALL'

      xtradb_innodb_buffer_pool_instances: 8
      xtradb_innodb_buffer_pool_size: "384M"
      xtradb_innodb_file_format: "Barracuda"
      xtradb_innodb_file_format_check: "1"
      xtradb_innodb_file_per_table: "on"
      xtradb_innodb_flush_log_at_trx_commit: "1"
      xtradb_innodb_log_buffer_size: "16M"
      xtradb_innodb_log_file_size: "50M"
      xtradb_innodb_strict_mode: "on"
      xtradb_join_buffer_size: "128K"
      xtradb_log_warnings: "1"
      xtradb_long_query_time: "10"
      xtradb_max_allowed_packet: "16M"
      xtradb_max_connections: "505"
      xtradb_max_heap_table_size: "16M"
      xtradb_max_user_connections: "500"
      xtradb_query_cache_size: "0"   # disable
      xtradb_read_buffer_size: "128K"
      xtradb_read_rnd_buffer_size: "256k"
      xtradb_skip_name_resolve: "1"
      xtradb_slow_query_log: "1"
      xtradb_sort_buffer_size: "2M"
      xtradb_table_definition_cache: "1400"
      xtradb_table_open_cache: "2000"
      xtradb_table_open_cache_instances: "8"
      xtradb_tmp_table_size: "16M"

```


```ini
[db]
node1 ansible_host=192.168.1.173
node2 ansible_host=192.168.1.156
node3 ansible_host=192.168.1.154
```

## Testing

There are two types of test environments available. One powered by Vagrant, another by Docker. The latter is suitable for running automated tests on Travis-CI. Test code is kept in separate orphan branches. For details of how to set up these test environments on your own machine, see the README files in the respective branches:

- Docker: [docker-tests](https://github.com/cdelgehier/ansible-role-XtraDB-Cluster/tree/docker-tests)

## Remove

To remove alltraces and start a new install 

```
ansible  db -m shell -a 'rm -rf /var/lib/mysql /var/log/mysqld.log /etc/percona-xtradb-cluster.conf.d ; yum remove Percona* -y'
```
## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.

Pull requests are also very welcome. The best way to submit a PR is by first creating a fork of this Github project, then creating a topic branch for the suggested change and pushing that branch to your own fork. Github can then easily create a PR based on that branch.

## License

2-clause BSD license, see [LICENSE.md](LICENSE.md)

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier/) (maintainer)
