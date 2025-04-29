# typed: false
# frozen_string_literal: true

class Dingo < Formula
  desc "Cardano data node built in Go"
  homepage "https://github.com/blinklabs-io/dingo"
  version "0.21.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blinklabs-io/dingo/releases/download/v0.21.0/dingo-v0.21.0-darwin-arm64.tar.gz"
      sha256 "7f62e7033853d14aa30f3015692a80d7734e223397deb762ca4edaf5c92c37c3"

      def install
        bin.install "dingo"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/blinklabs-io/dingo/releases/download/v0.21.0/dingo-v0.21.0-linux-amd64.tar.gz"
      sha256 "728c8f21bb61a96ab974a12cbe709cb7f6aa5f8a5cc1aa066bc73d9c1157031d"

      def install
        bin.install "dingo"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/blinklabs-io/dingo/releases/download/v0.21.0/dingo-v0.21.0-linux-arm64.tar.gz"
      sha256 "adc552f57eaba294b0c698654107f5b0f2051479a15e73d8d810b381822e5264"

      def install
        bin.install "dingo"
      end
    end
  end
end
