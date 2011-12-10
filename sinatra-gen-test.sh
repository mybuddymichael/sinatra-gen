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
  grep AssetPack foo/app.rb
  grep mustache foo/app.rb
}

it_creates_a_gemfile() {
  $sinatra_gen foo
  test -f foo/Gemfile
  grep sinatra foo/Gemfile
  grep mustache foo/Gemfile
  grep end foo/Gemfile
}

it_creates_a_config_ru_file() {
  $sinatra_gen foo
  test -f foo/config.ru
  grep app.rb foo/config.ru
  grep App foo/config.ru
}

it_creates_a_layout_view() {
  $sinatra_gen foo
  file=foo/views/layout.rb
  test -f $file
  grep Layout $file
  grep @title $file
}

it_creates_a_layout_template() {
  $sinatra_gen foo
  file=foo/templates/layout.mustache
  test -f $file
  grep doctype $file
  grep title $file
  grep yield $file
}

it_creates_an_index_view() {
  $sinatra_gen foo
  file=foo/views/index.rb
  test -f $file
  grep Index $file
  grep end $file
}
