class HealCli < Formula
  desc "Hook-driven Evaluation & Autonomous Loop — code-health harness CLI for AI coding agents"
  homepage "https://github.com/kechol/heal"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.5.0/heal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "495bfbb04d617c310c959b4c039d158802940f9d749384aa7ed049d0ba727b84"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.5.0/heal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0dddf4d93a2dccbac6038746fcd695665baf208162df4a354d86124bff9baa6d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.5.0/heal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a461a5e4056315e3d6e2c8b367bc85200be2d18fc871abe38d1f4de11e6f23c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.5.0/heal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8e4d51729195d192de61e4b68cb7c3b830eff540264fbacecb573dce43a30c73"
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
