class Kura < Formula
  desc "Local knowledge management CLI with Japanese-aware hybrid search"
  homepage "https://github.com/kechol/kura"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/kechol/kura/releases/download/v0.1.0/kura-darwin-arm64.tar.gz"
      sha256 "78be73f4410cc311f958bf556be6219ad6a51b254c6b6e6753f7705eaa9f8dbd"
    end
    on_intel do
      url "https://github.com/kechol/kura/releases/download/v0.1.0/kura-darwin-x64.tar.gz"
      sha256 "0d808e312088f7cd8cfe3c2a5a97662f7bb34224426fc1d0288eab4b9b2196eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kechol/kura/releases/download/v0.1.0/kura-linux-arm64.tar.gz"
      sha256 "5a8820965066e3bac30ad989b49d57e698891376d6e9cf985ea3d9a3512e1ea2"
    end
    on_intel do
      url "https://github.com/kechol/kura/releases/download/v0.1.0/kura-linux-x64.tar.gz"
      sha256 "70fc8ad29bb4b5601a1ce5daae65d6549aaa6f316c66cfee648b110632cbeca2"
    end
  end

  # macOS needs the Homebrew SQLite keg: Apple's bundled SQLite cannot load
  # the sqlite-vec / sqlite-vaporetto extensions kura relies on.
  depends_on "sqlite"

  def install
    bin.install "kura"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kura --version")
  end
end
