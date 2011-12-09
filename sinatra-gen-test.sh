#!/usr/bin/env roundup

describe 'sinatra-gen: generates a starter Sinatra project'

sinatra_gen='./sinatra-gen'

it_displays_help_when_called_without_arguments() {
  $sinatra_gen | grep USAGE
}
