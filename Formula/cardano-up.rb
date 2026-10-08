# typed: false
# frozen_string_literal: true

class CardanoUp < Formula
  desc "Command-line utility for managing Cardano services for local development"
  homepage "https://github.com/blinklabs-io/cardano-up"
  url "https://github.com/blinklabs-io/cardano-up/archive/refs/tags/v0.18.0.tar.gz"
  sha256 "97953d7b323261604aa2031008b5a76c84e00bded5f95153a4aebe85e3af822f"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X github.com/blinklabs-io/cardano-up/internal/version.Version=v#{version}
      -X github.com/blinklabs-io/cardano-up/internal/version.CommitHash=fd101ee
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/cardano-up"
  end

  test do
    assert_match(/cardano-up v#{Regexp.escape(version.to_s)} \(commit [0-9a-f]{7,40}\)/,
                 shell_output("#{bin}/cardano-up version 2>&1").strip)
  end
end
