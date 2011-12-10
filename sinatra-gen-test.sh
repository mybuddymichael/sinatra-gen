#!/usr/bin/env roundup

describe 'sinatra-gen: generates a starter Sinatra project'

sinatra_gen='./sinatra-gen'

after() {
  rm -rf foo
}

it_displays_help_when_called_without_arguments() {
  $sinatra_gen | grep USAGE
}

it_displays_help_when_called_with_h() {
  $sinatra_gen -h | grep USAGE
}

it_displays_help_when_called_with_help() {
  $sinatra_gen --help | grep USAGE
}

it_fails_when_called_with_an_unknown_argument() {
  $sinatra_gen -f 2>&1 | grep UNKNOWN
  $sinatra_gen --he 2>&1 | grep UNKNOWN
}

it_displays_the_unknown_argument_in_the_error_message() {
  $sinatra_gen -f 2>&1 | grep "\-f"
  $sinatra_gen --he 2>&1 | grep "--he"
}

it_creates_a_directory_with_the_name_provided() {
  $sinatra_gen foo
  test -d foo
}

it_does_not_create_a_directory_if_it_already_exists() {
  mkdir foo
  $sinatra_gen foo 2>&1 | grep EXISTS
}

it_creates_an_app_dot_rb_file() {
  $sinatra_gen foo
  test -f foo/app.rb
  grep Bundler foo/app.rb
  grep mustache foo/app.rb
}
