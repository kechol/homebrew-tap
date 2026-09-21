class BrowserReview < Formula
  desc "Browser annotations for local coding agents"
  homepage "https://github.com/kechol/browser-review"
  url "https://registry.npmjs.org/browser-review/-/browser-review-0.3.1.tgz"
  sha256 "48683a43692087356263bf4e585854cf95ce55b95bbe06dfc777d71b31d157df"
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
