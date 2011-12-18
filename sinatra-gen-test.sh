#!/usr/bin/env roundup

describe 'sinatra-gen: generates a starter Sinatra project'

alias sinatra-gen='./sinatra-gen'
alias grep='grep -i'

check() {
  test -f $1
  grep $2 $1
}

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
  check $file Sinatra::Base
}

it_creates_a_gemfile() {
  sinatra-gen foo
  file=foo/Gemfile
  check $file sinatra/base
}

it_creates_a_procfile() {
   sinatra-gen foo
   file=foo/Procfile
   check $file bundle
}

it_creates_a_guardfile() {
  sinatra-gen foo
  file=foo/Guardfile
  check $file guard
}

it_creates_a_config_ru_file() {
  sinatra-gen foo
  file=foo/config.ru
  check $file app.rb
}

it_creates_a_layout_view() {
  sinatra-gen foo
  file=foo/views/layout.rb
  check $file @title
}

it_creates_a_layout_template() {
  sinatra-gen foo
  file=foo/templates/layout.mustache
  check $file yield
}

it_creates_an_index_view() {
  sinatra-gen foo
  file=foo/views/index.rb
  check $file Index
}

it_creates_an_index_template() {
  sinatra-gen foo
  file=foo/templates/index.mustache
  check $file world
}

it_creates_a_test_helper_file() {
  sinatra-gen foo
  file=foo/test/test_helper.rb
  check $file require_relative
}

it_creates_a_routes_test_file() {
  sinatra-gen foo
  file=foo/test/routes_test.rb
  check $file require_relative
}

it_creates_reset_scss() {
  sinatra-gen foo
  file=foo/styles/reset.scss
  check $file body
}

it_creates_main_coffee() {
  sinatra-gen foo
  file=foo/scripts/main.coffee
  test -f $file
}

it_passes_rack_tests() {
  sinatra-gen foo
  cd foo
  bundle install
  test -z "$(bundle exec ruby test/routes_test.rb | grep 'Failure:\|Error:')"
}
