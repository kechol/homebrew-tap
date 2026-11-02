class Heal < Formula
  desc "Hook-driven Evaluation & Autonomous Loop — code-health harness CLI for AI coding agents"
  homepage "https://github.com/kechol/heal"
  version "0.7.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.7.2/heal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3d62585d9a28297b3b471b57cc79e4bf1b710f20ba83fbbdc24120c0505eafb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.7.2/heal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b8c0819d8b2c470037f019fb5da6e0c8844e493acc5744ebff2fbdef47f5ac33"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.7.2/heal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4b4459080b6d14b8e2f9b2004f2bf20e2223e711144fdfba9e78c93ade8c8ba1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.7.2/heal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7ca812949457d50e46c5c1ef82a03b78d335c0ce134e607e04c194d7769f87ad"
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
