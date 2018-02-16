#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

user="travis"
pass="travispw"
dbname="travis"
tablename="${dbname}.myTableTest"
tabledesc="(id int not null, name varchar(30) not null, PRIMARY KEY (id))"
tablerow="(1, 'travis')"

# Tests
@test 'Create database on master' {
  run mysql -ss -u${user} -p${pass} -h 172.17.0.2 -e "create database ${dbname}"

  [ ${status} -eq 0 ]
}

@test 'Database is present on a slave' {
  run mysql -ss -u${user} -p${pass} -h 172.17.0.3 -e "use ${dbname}"

  [ "${status}" -eq "0" ]
}

@test 'A first slave create a table in this base' {
  run mysql -ss -u${user} -p${pass} -h 172.17.0.3 -e "create table ${tablename} ${tabledesc}"

  [ "${status}" -eq "0" ]
}

@test 'The second slave insert in this table' {
  run mysql -ss -u${user} -p${pass} -h 172.17.0.4 -e "insert into ${tablename} values ${tablerow}"

  [ "${status}" -eq "0" ]
}

@test 'The master drop all' {
  run mysql -ss -u${user} -p${pass} -h 172.17.0.2 -e "drop database ${dbname}"

  [ "${status}" -eq "0" ]
}

@test 'A slave check the drop' {
  run mysql -ss -u${user} -p${pass} -h 172.17.0.2 -e "use ${dbname}"

  [ "${status}" -eq "1" ]
}
