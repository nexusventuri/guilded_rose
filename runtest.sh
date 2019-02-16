#!/bin/bash

set -e
echo 'Running specs'
bundle exec rspec spec/*spec.rb

set +e
output_file='spec/fixture/out.txt'
bundle exec ruby spec/texttest_fixture.rb > "$output_file"
diff spec/fixture/original_output.txt "$output_file"

if [[ $? == 1 ]]; then
  echo 'fixture failed'
  exit 1
else
  echo 'passed'
  exit 0
fi

