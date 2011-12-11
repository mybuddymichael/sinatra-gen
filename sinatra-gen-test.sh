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

it_creates_an_app_dot_rb_file() {
  sinatra-gen foo
  test -f foo/app.rb
  grep Sinatra::Base foo/app.rb
}

it_creates_a_gemfile() {
  sinatra-gen foo
  test -f foo/Gemfile
  grep sinatra/base foo/Gemfile
}

it_creates_a_config_ru_file() {
  sinatra-gen foo
  test -f foo/config.ru
  grep app.rb foo/config.ru
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
