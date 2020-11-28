load functions

@test "Check non png file" {
  run_pngpetite ${BATS_TEST_DIRNAME}/functions.bash
  [[ ${output} =~ 'does not appear to be a png file' ]]
}

@test "Check non existing file" {
  run_pngpetite ${BATS_TEST_DIRNAME}/non-existing-file.png
  [[ ${output} =~ 'does not appear to be a png file' ]]
}
