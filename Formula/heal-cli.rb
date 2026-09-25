class HealCli < Formula
  desc "Hook-driven Evaluation & Autonomous Loop — code-health harness CLI for AI coding agents"
  homepage "https://github.com/kechol/heal"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.7.1/heal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4b13f5b8161503a94e49b2045790f1135e6413d4b7b206950386a5c508e22af4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.7.1/heal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ea153813c42e4b20f7810cb982698e2297a798c18bcfdab731cd062f0223cf15"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.7.1/heal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3a0f6b4f899ecdba1d77fc089f7104b63e8af24257dc35277ce28add661d936b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.7.1/heal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5d9f2399fea2add8bab88ea6a899a2697c238088c40e411d907a795503978ba9"
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
