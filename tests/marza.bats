#!/usr/bin/env bats

setup() {
  export MARZA_TESTING=1
  source /root/.local/bin/marza
}

@test "detect_architecture: x86_64 maps to x64" {
  uname() { echo x86_64; }
  is_musl() { return 1; }
  run detect_architecture
  [[ $status -eq 0 ]]
  [[ $output == "x64" ]]
}

@test "detect_architecture: x86_64 + musl maps to x64-musl" {
  uname() { echo x86_64; }
  is_musl() { return 0; }
  run detect_architecture
  [[ $output == "x64-musl" ]]
}

@test "validate_version: rejects garbage input" {
  run validate_version "24..0"
  [[ $status -eq 1 ]]
}

@test "validate_version: passes through full semver" {
  run validate_version "22.1.0"
  [[ $output == "22.1.0" ]]
}
