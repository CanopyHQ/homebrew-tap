# typed: false
# frozen_string_literal: true

# Phloem - Local-first AI Memory with Causal Graphs
# Persistent context for AI coding tools via MCP
class Phloem < Formula
  desc "Local-first AI memory with causal graphs via MCP"
  homepage "https://github.com/CanopyHQ/phloem"
  version "0.1.3"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/CanopyHQ/phloem/releases/download/v0.1.3/phloem-darwin-arm64.tar.gz"
    sha256 "ab86870f2121e5ab1e247f9b0fc1dd25d705f8855439848b55686802bbbfd256"
  else
    url "https://github.com/CanopyHQ/phloem/releases/download/v0.1.3/phloem-darwin-amd64.tar.gz"
    sha256 "d2d1cdbfce8a679cd0f8669a8681f5dbfcab6bd4929acb35ae5bf072dc3d8a19"
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
