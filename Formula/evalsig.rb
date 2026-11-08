class Evalsig < Formula
  desc "Command-line interface for evalsig: statistics and signal detection for evaluation records"
  homepage "https://github.com/kechol/evalsig"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/evalsig/releases/download/v0.1.0/evalsig-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3ce665dbb0adf029fd6c688b775b0671fd41bf4760c25eaed44779ae018b88f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/evalsig/releases/download/v0.1.0/evalsig-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6f32118da117cc4e258de1528eb0734437be921340c0618c420ff3625e6c5165"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/evalsig/releases/download/v0.1.0/evalsig-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "61834ac913d83e60e373be90e8bb4be8c5cd0b40f7da32a75f121fe6753a9bb0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/evalsig/releases/download/v0.1.0/evalsig-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "44282e94d512043c3286f0599d432fbfcd7d7daa3f7dc9e791ca6254755031a1"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "evalsig"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "evalsig"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "evalsig"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "evalsig"
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
