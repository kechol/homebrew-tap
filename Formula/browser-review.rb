class BrowserReview < Formula
  desc "Browser annotations for local coding agents"
  homepage "https://github.com/kechol/browser-review"
  url "https://registry.npmjs.org/browser-review/-/browser-review-0.3.0.tgz"
  sha256 "7df63ecdfebc01525cb1087a27da9a08dd0ad139abcc1e2fc316bc67270dc73c"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args, "--ignore-scripts"
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match "browser-review open", shell_output("#{bin}/browser-review --help")
    ENV["XDG_STATE_HOME"] = testpath/"state"
    assert_equal({ "sessions" => [] }, JSON.parse(shell_output("#{bin}/browser-review status --json")))
  end
end
