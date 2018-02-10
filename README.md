# Ansible role `ansible-XtraDB-Cluster`

An Ansible role for setup a percon XtraDB Cluster. Specifically, the responsibilities of this role are to:

- install packages
- secure connections
- bootstrap the cluster

## Requirements

No specific requirements

## Role Variables


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
| `xtradb_options_config_files` | - | Minimal configuration options |
| `xtradb_root_password` | `root` | Password for the root user |
| `xtradb_root_user` | `root` | The root user |
| `xtradb_secured` | `xtradb_datadir`/secured |A cookie for idempotency |
| `xtradb_service` | `mysql` | Linux service name  |
| `xtradb_sst_password` | `sstpassword` | Password for the `xtradb_sst_user` |
| `xtradb_sst_user` | `sstuser` | User used to the state snapshot transfer  |
| `xtradb_version` | `57` | Package version of XtraDB |

## Dependencies

No dependencies.

## Example Playbook


## Testing

There are two types of test environments available. One powered by Vagrant, another by Docker. The latter is suitable for running automated tests on Travis-CI. Test code is kept in separate orphan branches. For details of how to set up these test environments on your own machine, see the README files in the respective branches:

- Docker: [docker-tests](https://github.com/cdelgehier/ansible-role-ansible-XtraDB-Cluster/tree/docker-tests)

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.

Pull requests are also very welcome. The best way to submit a PR is by first creating a fork of this Github project, then creating a topic branch for the suggested change and pushing that branch to your own fork. Github can then easily create a PR based on that branch.

## License

2-clause BSD license, see [LICENSE.md](LICENSE.md)

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier/) (maintainer)

