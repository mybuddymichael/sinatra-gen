#!/usr/bin/env roundup

describe 'sinatra-gen: generates a starter Sinatra project'

sinatra_gen='./sinatra-gen'

it_displays_help_when_called_without_arguments() {
  $sinatra_gen | grep USAGE
}

it_displays_help_when_called_with_h() {
  echo $($sinatra_gen -h) | grep USAGE
}

it_displays_help_when_called_with_help() {
  echo $($sinatra_gen --help) | grep USAGE
}

it_fails_when_called_with_an_unknown_argument() {
  echo $($sinatra_gen -f ) | grep UNKNOWN
  echo $($sinatra_gen --he ) | grep UNKNOWN
}
