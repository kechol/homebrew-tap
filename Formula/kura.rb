class Kura < Formula
  desc "Local knowledge management CLI with Japanese-aware hybrid search"
  homepage "https://github.com/kechol/kura"
  version "0.3.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/kechol/kura/releases/download/v0.3.2/kura-darwin-arm64.tar.gz"
      sha256 "847ee3d91af75c75e6d89d21f733ff3ee005fad497b802df33818e8af772a56d"
    end
    on_intel do
      url "https://github.com/kechol/kura/releases/download/v0.3.2/kura-darwin-x64.tar.gz"
      sha256 "93877650a333b2761a30fd8461cd749cddbb647a6fdead129cb090a055580112"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kechol/kura/releases/download/v0.3.2/kura-linux-arm64.tar.gz"
      sha256 "459d38199d7e93b4efe427f1e22261d4f2e8230ae864f996f07058746735b843"
    end
    on_intel do
      url "https://github.com/kechol/kura/releases/download/v0.3.2/kura-linux-x64.tar.gz"
      sha256 "a8c2d15ab25a316a9c94e5000d17d9233571de796aebd55b266a85be91e448f3"
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
