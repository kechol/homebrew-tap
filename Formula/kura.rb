class Kura < Formula
  desc "Local knowledge management CLI with Japanese-aware hybrid search"
  homepage "https://github.com/kechol/kura"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/kechol/kura/releases/download/v0.3.1/kura-darwin-arm64.tar.gz"
      sha256 "2d142db510cdfd103943b3be62b63c1ecb1cf7c351ed48c700f24595aba70aa5"
    end
    on_intel do
      url "https://github.com/kechol/kura/releases/download/v0.3.1/kura-darwin-x64.tar.gz"
      sha256 "8b3287d05652ba10ed95741790ec8501f1c63d27ec5a892a9ceb0650d97c1938"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kechol/kura/releases/download/v0.3.1/kura-linux-arm64.tar.gz"
      sha256 "24ae2822adcb781eef40e506069a54cc35e6063cc7bd6fdf5071c779ca70e1a7"
    end
    on_intel do
      url "https://github.com/kechol/kura/releases/download/v0.3.1/kura-linux-x64.tar.gz"
      sha256 "7917939efda8d34ee63d2cc61697c53b5a07dff0a1572a39e2235d9ea997a873"
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
