# typed: false
# frozen_string_literal: true

class Dingo < Formula
  desc "Cardano data node built in Go"
  homepage "https://github.com/blinklabs-io/dingo"
  url "https://github.com/blinklabs-io/dingo/archive/refs/tags/v0.90.4.tar.gz"
  sha256 "fe9dd1a87dd6387e9bfa801a7598525f6df344f5caf2c265a351739cc97db73c"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    # Mirror upstream's Makefile build: CGO-free, the default
    # dingo_extra_plugins tag, and a stamped version package so
    # "dingo version" reports the release instead of "devel".
    # A release tarball carries no git metadata, so the tag's commit is
    # recorded here and must be updated alongside the url.
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X github.com/blinklabs-io/dingo/internal/version.Version=v#{version}
      -X github.com/blinklabs-io/dingo/internal/version.CommitHash=fb573b9
    ]
    system "go", "build", *std_go_args(ldflags:, tags: "dingo_extra_plugins"), "./cmd/dingo"
  end

  test do
    # The version package must be stamped: an unstamped build reports
    # "devel (commit )" and an unstamped commit leaves the hash empty.
    assert_match(/\Av#{Regexp.escape(version.to_s)} \(commit [0-9a-f]{7,40}\)\z/,
                 shell_output("#{bin}/dingo version").strip)

    # An unknown subcommand must fail rather than start a node.
    assert_match "unknown command", shell_output("#{bin}/dingo not-a-command 2>&1", 1)
  end
end
