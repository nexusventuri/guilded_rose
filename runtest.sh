#!/bin/bash

set -e
echo 'Running specs'
bundle exec rspec spec/*spec.rb

set +e
output_file='spec/fixture/out.txt'
bundle exec ruby spec/texttest_fixture.rb > "$output_file"
diff spec/fixture/original_output.txt "$output_file"

if [[ $? != 0 ]]; then
  echo 'Fixture failed'
  exit 1
else
  echo 'Fixture passed'
  exit 0
fi

