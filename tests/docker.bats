#!/usr/bin/env bats

load functions

@test "Docker: Build docker image" {
  cd ${BATS_TEST_DIRNAME}/.. && \
  docker build -t uroesch/pngpetite .
}

@test "Docker Compress *.png" {
  testdir=${BATS_TEST_DIRNAME}/test-${RANDOM}
  mkdir -p ${testdir}
  cp ${BATS_TEST_DIRNAME}/../samples/original/*png ${testdir}
  ${BATS_TEST_DIRNAME}/../bin/docker-pngpetite ${testdir}/*png
  rm ${testdir}/*.png
}
