class ClaudeNotify < Formula
  desc "Native macOS notifications for Claude Code and OpenCode"
  homepage "https://github.com/Vibe-Marketer/claude-notify"
  url "https://github.com/Vibe-Marketer/claude-notify/archive/refs/tags/v3.1.0.tar.gz"
  sha256 "e2f254e4b0e6e2e723cc290747d6a7c911ff830572bdf01ecb81db479d4d4993"
  license "All-Rights-Reserved"

  depends_on :macos
  depends_on xcode: ["15.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/claude-notify"
    bin.install "bin/claude-notify-setup"
    (share/"claude-notify").install "hooks/notify-complete.sh"
  end

  def caveats
    <<~EOS
      To complete setup, run:

        claude-notify-setup

      This will install the hook script and configure Claude Code
      and/or OpenCode to send notifications when responses complete.

      You only need to run setup once. Future `brew upgrade` will
      update the binary automatically without re-running setup.
    EOS
  end

  test do
    assert_predicate bin/"claude-notify", :executable?
    assert_predicate bin/"claude-notify-setup", :executable?
  end
end

