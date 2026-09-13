class Kura < Formula
  desc "Local knowledge management CLI with Japanese-aware hybrid search"
  homepage "https://github.com/kechol/kura"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/kechol/kura/releases/download/v0.3.0/kura-darwin-arm64.tar.gz"
      sha256 "ce795c7b82c1967f37cceb712c5dbaef6d42d2ca02ac42c6b75fb2b7283c9240"
    end
    on_intel do
      url "https://github.com/kechol/kura/releases/download/v0.3.0/kura-darwin-x64.tar.gz"
      sha256 "4c1f84e7810299fa5ce06921b28144e6730d6a8e5ada84e046a58d7195bae1a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kechol/kura/releases/download/v0.3.0/kura-linux-arm64.tar.gz"
      sha256 "b61661bd82e283c640cc19d8b6bb5e12404a3b008945e45635ea35092e5f823e"
    end
    on_intel do
      url "https://github.com/kechol/kura/releases/download/v0.3.0/kura-linux-x64.tar.gz"
      sha256 "589179d94c72e7b284969362383b59a9baa37b9278d977b95e361763d467acfe"
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
