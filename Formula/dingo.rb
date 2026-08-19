# typed: false
# frozen_string_literal: true

class Dingo < Formula
  desc "Cardano data node built in Go"
  homepage "https://github.com/blinklabs-io/dingo"
  version "0.69.0"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/blinklabs-io/homebrew-cardano/releases/download/dingo-0.69.0"
    sha256 cellar: :any_skip_relocation, arm64_linux: "fc0e99b11bb53b69c98b958a42b640514366bfaeb48f564c30edea9299adf5bf"
  end

  on_macos do
    on_arm do
      url "https://github.com/blinklabs-io/dingo/releases/download/v0.69.0/dingo-v0.69.0-darwin-arm64.tar.gz"
      sha256 "a52684871205d3ce00d1a51167274ba0bbed0e6d14352d65a5162957b93c7af2"
    end
    on_intel do
      disable! date: "2026-08-19", because: :unsupported
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/blinklabs-io/dingo/releases/download/v0.69.0/dingo-v0.69.0-linux-amd64.tar.gz"
      sha256 "2562f11a9c4029d1b4ccef53186639014e0611a44b59d15b260fe0d0621acfd1"
    end
    on_arm do
      url "https://github.com/blinklabs-io/dingo/releases/download/v0.69.0/dingo-v0.69.0-linux-arm64.tar.gz"
      sha256 "33485531cda790cdf5118e970de505566c9efda020dc0c5a40127acde510c71d"
    end
  end

  def install
    bin.install "dingo"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dingo version")
  end
end
