class HealCli < Formula
  desc "Hook-driven Evaluation & Autonomous Loop — code-health harness CLI for AI coding agents"
  homepage "https://github.com/kechol/heal"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.3.2/heal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "eac7a9ac59a5257c208d9fd141637d4e80e060d901ea4c4bf8d46f7bf5755d52"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.3.2/heal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f9a1f54579240c321232188b64e9abad42472e0fbe72c7341095ebc8d4924da9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.3.2/heal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0bc45218548bf28274b853a8fa687da74e75b2b14e7f299767a3d32bc89b8006"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.3.2/heal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a8aecd387db05e59cd911c28b2ae245bb492c2a43296ed692d26b167f92adbf6"
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
    bin.install "heal" if OS.mac? && Hardware::CPU.arm?
    bin.install "heal" if OS.mac? && Hardware::CPU.intel?
    bin.install "heal" if OS.linux? && Hardware::CPU.arm?
    bin.install "heal" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
