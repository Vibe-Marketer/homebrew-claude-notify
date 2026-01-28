class ClaudeNotify < Formula
  desc "Native macOS notifications for Claude Code and OpenCode"
  homepage "https://github.com/vibe-marketer/claude-notify"
  url "https://github.com/vibe-marketer/claude-notify/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER"
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
