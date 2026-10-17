class BrowserReview < Formula
  desc "Browser annotations for local coding agents"
  homepage "https://github.com/kechol/browser-review"
  url "https://registry.npmjs.org/browser-review/-/browser-review-0.4.0.tgz"
  sha256 "734b76f0818dff77e9d01984e36186943364737ca28588468607a957c521b8a9"
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
