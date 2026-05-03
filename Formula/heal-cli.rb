class HealCli < Formula
  desc "Hook-driven Evaluation & Autonomous Loop — code-health harness CLI for AI coding agents"
  homepage "https://github.com/kechol/heal"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.3.1/heal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3afc3c6aec24d14df8669bc09c4881427dddad2b2cd000111b93bc6b39d3d526"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.3.1/heal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "df3547e618da808a656bff52bfea9e7d33b1a362e2d2941569bbf8858bee8494"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.3.1/heal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "83fa6f3cf299ae610aef30d1e6c230ee87f04a622b2bc8f4d1b7edef3eaeaa6a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.3.1/heal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3b8571f70d27599adb297f910731e49029ea6bc6627f12c535f554227c456f6a"
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
