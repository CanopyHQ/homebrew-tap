# typed: false
# frozen_string_literal: true

# Phloem - Local-first AI Memory with Causal Graphs
# Persistent context for AI coding tools via MCP
class Phloem < Formula
  desc "Local-first AI memory with causal graphs via MCP"
  homepage "https://github.com/CanopyHQ/phloem"
  version "0.1.1"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/CanopyHQ/phloem/releases/download/v0.1.1/phloem-darwin-arm64.tar.gz"
    sha256 "e75f54ca0589cbff75383a719c0de17e71da465d0e682ca06d4bc0624b7a3a9a"
  else
    url "https://github.com/CanopyHQ/phloem/releases/download/v0.1.1/phloem-darwin-amd64.tar.gz"
    sha256 "5092ba9532aabe416cd4364690705edb71945c980a545aed4cf868764f0bc7ab"
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
