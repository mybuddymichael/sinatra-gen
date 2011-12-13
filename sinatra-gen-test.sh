#!/usr/bin/env roundup

describe 'sinatra-gen: generates a starter Sinatra project'

alias sinatra-gen='./sinatra-gen'
alias grep='grep -i'

after() {
  rm -rf foo
}

it_displays_help_when_called_without_arguments() {
  sinatra-gen | grep Usage
}

it_displays_help_when_called_with_h() {
  sinatra-gen -h | grep Usage
}

it_displays_help_when_called_with_help() {
  sinatra-gen --help | grep Usage
}

it_fails_when_called_with_an_unknown_argument() {
  sinatra-gen -f 2>&1 | grep unknown
  sinatra-gen --he 2>&1 | grep unknown
}

it_displays_the_unknown_arg_with_the_error() {
  sinatra-gen -f 2>&1 | grep "\-f"
  sinatra-gen --he 2>&1 | grep "--he"
}

it_always_displays_help_if_h_is_flagged() {
  sinatra-gen -h -d foo | grep Usage
  sinatra-gen -d -h foo | grep Usage
  test ! -d foo
}

it_creates_a_directory_with_the_name_provided() {
  sinatra-gen foo
  test -d foo
}

it_does_not_create_if_directory_already_exists() {
  mkdir foo
  sinatra-gen foo 2>&1 | grep exists
}

it_prints_the_files_being_created() {
  sinatra-gen foo | grep create
}

it_does_not_create_if_dry_run() {
  sinatra-gen -d foo | grep app.rb
  test ! -d foo
}

it_creates_an_app_dot_rb_file() {
  sinatra-gen foo
  file=foo/app.rb
  test -f $file
  grep Sinatra::Base $file
}

it_creates_a_gemfile() {
  sinatra-gen foo
  file=foo/Gemfile
  test -f $file
  grep sinatra/base $file
}

it_creates_a_config_ru_file() {
  sinatra-gen foo
  file=foo/config.ru
  test -f $file
  grep app.rb $file
}

it_creates_a_layout_view() {
  sinatra-gen foo
  file=foo/views/layout.rb
  test -f $file
  grep @title $file
}

it_creates_a_layout_template() {
  sinatra-gen foo
  file=foo/templates/layout.mustache
  test -f $file
  grep yield $file
}

it_creates_an_index_view() {
  sinatra-gen foo
  file=foo/views/index.rb
  test -f $file
  grep Index $file
}

it_creates_an_index_template() {
  sinatra-gen foo
  file=foo/templates/index.mustache
  test -f $file
  grep world $file
}

it_creates_a_test_helper_file() {
  sinatra-gen foo
  file=foo/test/test_helper.rb
  test -f $file
  grep require_relative $file
}

it_creates_a_routes_test_file() {
  sinatra-gen foo
  file=foo/test/routes_test.rb
  test -f $file
  grep require_relative $file
}
