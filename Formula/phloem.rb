# typed: false
# frozen_string_literal: true

# Phloem - Local-first AI Memory with Causal Graphs
# Persistent context for AI coding tools via MCP
class Phloem < Formula
  desc "Local-first AI memory with causal graphs via MCP"
  homepage "https://github.com/CanopyHQ/phloem"
  version "0.1.8"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/CanopyHQ/phloem/releases/download/v0.1.8/phloem-darwin-arm64.tar.gz"
    sha256 "1305ed08b50e5500967b7bc48910d2b64b15c1a00ebfae1d06068e69e6bd2743"
  else
    url "https://github.com/CanopyHQ/phloem/releases/download/v0.1.8/phloem-darwin-amd64.tar.gz"
    sha256 "89827b80b383e98b82adb08125bcda48146810df378be0ff161e01ff501e4c6a"
  end

  def install
    bin.install "phloem"
  end

  def post_install
    (var/"phloem").mkpath
  end

  def caveats
    <<~EOS
      Phloem is installed!

      Quick Setup:
        phloem setup              # Auto-detect and configure all IDEs
        phloem setup cursor       # Configure Cursor IDE
        phloem setup windsurf     # Configure Windsurf IDE
        phloem setup claude-code  # Configure Claude Code

      Commands:
        phloem status             # Check memory status
        phloem doctor             # Diagnose setup issues
        phloem audit              # Privacy and data audit
        phloem help               # Full command list

      Documentation: https://github.com/CanopyHQ/phloem
    EOS
  end

  test do
    assert_match "phloem", shell_output("#{bin}/phloem version 2>&1")
  end
end
