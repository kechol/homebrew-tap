class HealCli < Formula
  desc "Hook-driven Evaluation & Autonomous Loop — code-health harness CLI for AI coding agents"
  homepage "https://github.com/kechol/heal"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.6.0/heal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "50dc36e44e78883c34026bac53227eae2ad6d7b9b452aec961676052e388b7cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.6.0/heal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0695f54de3ecdec29536c36e2411b6e71be1ee9d179c0ed57e069002a0e9f0e9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.6.0/heal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0ee29cdb2f5a55a13c4f3a98d2951b621cc31d0fd1242f0589b9548bf66dea60"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.6.0/heal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f3a70610e8fc228dd12503d245cb192e3705050b9ed10ca43372876d5f7c6fa7"
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
