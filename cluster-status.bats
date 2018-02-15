#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

user='travis'
pass='travispw'

# Tests
@test 'Anonymous access should not work' {
  run mysql -ss -u'' -h ${SUT_IP} -e ';'

  [ ${status} -eq 1 ]
}

@test 'Travis user connection' {
  run mysql -ss -u${user} -p${pass} -h ${SUT_IP} -e ';'

  [ "${status}" -eq "0" ]
}

@test 'Number of nodes in cluster' {
  run mysql -ss -u${user} -p${pass} -h ${SUT_IP} -e 'show global status where variable_name = "wsrep_cluster_size"'

  [ "${status}" -eq "0" ]
  [ "${output}" = "wsrep_cluster_size	3" ]
}

@test 'The node can accept queries' {
  run mysql -ss -u${user} -p${pass} -h ${SUT_IP} -e 'show global status where variable_name = "wsrep_ready"'

  [ "${status}" -eq "0" ]
  [ "${output}" = "wsrep_ready	ON" ]
}

@test 'the node has network connectivity with any other nodes' {
  run mysql -ss -u${user} -p${pass} -h ${SUT_IP} -e 'show global status where variable_name = "wsrep_connected"'

  [ "${status}" -eq "0" ]
  [ "${output}" = "wsrep_connected	ON" ]
}
