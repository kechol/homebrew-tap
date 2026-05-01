class HealCli < Formula
  desc "Hook-driven Evaluation & Autonomous Loop — code-health harness CLI for AI coding agents"
  homepage "https://github.com/kechol/heal"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.2.1/heal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c7754f1d9dce7cd0f791f55e392fd0174a2815d21044b887af665b3032332900"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.2.1/heal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "ccfad9fe2527a769ef948e9efb2c949f387a3ecadf76e08b61f536b530cf46f1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kechol/heal/releases/download/v0.2.1/heal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f4fffd175462ee00d40e71617703ce95e1c1f4daed214124e9db99dd69ba74f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kechol/heal/releases/download/v0.2.1/heal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "56d59e1f402ff3b01358aefdebc55a9cdb7203081a27276a7627de6b0ed732f9"
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
