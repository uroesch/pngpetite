#!/usr/bin/env bats

load functions

# 454289 beach.png
# 580777 cat.png
#  31049 happy-sun.png
#  53592 shinkansen-n700.png

@test "Compress beach.png" {
 compress_sample_png beach
}

@test "Compress cat.png" {
 compress_sample_png cat
}

@test "Compress happy-sun.png" {
 compress_sample_png happy-sun
}

@test "Compress shinkansen-n700.png" {
 compress_sample_png shinkansen-n700
}
