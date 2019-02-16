#!/bin/bash

function red {
  echo -e "\033[0;31m$1\033[0m"
}

function green {
  echo -e "\033[0;32m$1\033[0m"
}

set -e
echo 'Running specs'
bundle exec rspec spec/*spec.rb

set +e
output_file='spec/fixture/out.txt'
bundle exec ruby spec/texttest_fixture.rb > "$output_file"
diff spec/fixture/original_output.txt "$output_file"


if [[ $? != 0 ]]; then
  red '******************'
  red '* Fixture failed *'
  red '******************'
  exit 1
else
  echo ''
  green '******************'
  green '* Fixture passed *'
  green '******************'
  exit 0
fi

