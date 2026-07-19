class Kura < Formula
  desc "Local knowledge management CLI with Japanese-aware hybrid search"
  homepage "https://github.com/kechol/kura"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/kechol/kura/releases/download/v0.2.0/kura-darwin-arm64.tar.gz"
      sha256 "45a020eb5981475a10f10e1517b3ecd2cb96648f7144374b9910ca9c0e043f01"
    end
    on_intel do
      url "https://github.com/kechol/kura/releases/download/v0.2.0/kura-darwin-x64.tar.gz"
      sha256 "14af835a3be88baefbbb24113943f531e9c79b15040cbe190367d0260058a558"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kechol/kura/releases/download/v0.2.0/kura-linux-arm64.tar.gz"
      sha256 "f8e73d49a2c404dd5ef21199addfbe0206768c478eb3cee44cc755b2e9c90e3d"
    end
    on_intel do
      url "https://github.com/kechol/kura/releases/download/v0.2.0/kura-linux-x64.tar.gz"
      sha256 "d93849cfa4da2764dd7e177bed2d88a88a97252f54e264aa718ad02d54183def"
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
