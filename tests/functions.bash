# 454289 beach.png
# 580777 cat.png
#  31049 happy-sun.png
#  53592 shinkansen-n700.png

function compress_sample_png() {
  local name=${1}; shift
  local png=${name}.png
  local dir=${HOME}/tmp/pngpetite/${name}-${RANDOM}
  local imgdir=${BATS_TEST_DIRNAME}/../samples/original

  run_pngpetite "${imgdir}/${png}" "${dir}"
}

function run_pngpetite() {
  local png=${1}; shift;
  local dir=${1:-${HOME}/tmp/pngpetite/${RANDOM}}
  local bindir=${BATS_TEST_DIRNAME}/../bin

  run ${bindir}/pngpetite -d "${dir}" "${png}"
  [[ -f ${dir}/${png##*/} ]] || echo "${output}"
}
