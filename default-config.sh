#!/bin/bash

FILE="/vagrant/config/database.yml"

cat <<EOM >$FILE
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password: root

development:
  <<: *default
  database: handy_development

test:
  <<: *default
  database: handy_test
EOM

FILE="/vagrant/config/twilio.yml"

cat <<EOM >$FILE

development:
  account_sid: # Fill this in
  auth_token: # Fill this in
  phone_number: # Fill this in

test:
  account_sid: # Fill this in
  auth_token: # Fill this in
  phone_number: # Fill this in
EOM

cp /vagrant/config/secrets.yml.sample /vagrant/config/secrets.yml