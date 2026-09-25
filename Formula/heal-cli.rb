class HealCli < Formula
  desc "Hook-driven Evaluation & Autonomous Loop — code-health harness CLI for AI coding agents"
  homepage "https://github.com/kechol/heal"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.7.0/heal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "bf77797c7b4e3415d92b47da16cc16ea3dacb0207ea089a66a03491abc556125"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.7.0/heal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7de20089b0ea2899315f6b15a84fceeb3825330205d992c496a22d342ad89321"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.7.0/heal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d0ab4f55d7274cd33749bc5b946c443ea2a01a98550666475fd7dfbefd6efdaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.7.0/heal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "37bf2f4ae6d4f5dc6ab533228e715d71cbb49cdccb331c240cebe73915a860f2"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "heal"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "heal"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "heal"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "heal"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
