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
  echo $($sinatra_gen --he | head -n 3 ) | grep UNKNOWN
}

it_fails_when_called_with_an_unknown_argument_2() {
  echo $($sinatra_gen -f | head -n 3 ) | grep UNKNOWN
}
