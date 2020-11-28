load functions

@test "Regression: Check non PNG file" {
  run_pngpetite ${BATS_TEST_DIRNAME}/functions.bash || :
  [[ ${output,,} =~ 'unable to process file' ]]
}

@test "Regression: Check non existing file" {
  run_pngpetite ${BATS_TEST_DIRNAME}/non-existing-file.png || :
  [[ ${output,,} =~ 'unable to process file' ]]
}

@test "Regression: Check no options or file provided" {
  run ${BATS_TEST_DIRNAME}/../bin/pngpetite || :
  (( ${status} == 11 ))
}

@test "Regression: Check non-existing option" {
  run ${BATS_TEST_DIRNAME}/../bin/pngpetite --foobar || :
  (( ${status} == 12 ))
}
