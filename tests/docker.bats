#!/usr/bin/env bats

load functions

@test "Docker: Build docker image" {
  cd ${BATS_TEST_DIRNAME}/.. && \
  docker build -t uroesch/pngpetite .
}

@test "Docker: Compress *.png" {
  testdir=${BATS_TEST_DIRNAME}/test-${RANDOM}
  mkdir -p ${testdir}
  cp ${BATS_TEST_DIRNAME}/../samples/original/*png ${testdir}
  ${BATS_TEST_DIRNAME}/../bin/docker-pngpetite ${testdir}/*png
  rm ${testdir}/*.png
}

@test "Docker: Check file permission after compression" {
  testdir=${BATS_TEST_DIRNAME}/test-${RANDOM}
  mkdir -p ${testdir}
  cp ${BATS_TEST_DIRNAME}/../samples/original/beach.png ${testdir}
  perm_original=$(stat --format "%u:%g" ${testdir}/beach.png)
  ${BATS_TEST_DIRNAME}/../bin/docker-pngpetite ${testdir}/beach.png
  perm_shrunk=$(stat --format "%u:%g" ${testdir}/beach-pngpetite.png)
  [[ ${perm_shrunk} == ${perm_original} ]]
  rm ${testdir}/*.png
}
