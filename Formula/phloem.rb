# typed: false
# frozen_string_literal: true

# Phloem - Local-first AI Memory with Causal Graphs
# Persistent context for AI coding tools via MCP
class Phloem < Formula
  desc "Local-first AI memory with causal graphs via MCP"
  homepage "https://github.com/CanopyHQ/phloem"
  version "0.1.2"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/CanopyHQ/phloem/releases/download/v0.1.2/phloem-darwin-arm64.tar.gz"
    sha256 "07b78eb72eaaf12d550c5c7942b093c33f7a348358740541c75785b9d79e3294"
  else
    url "https://github.com/CanopyHQ/phloem/releases/download/v0.1.2/phloem-darwin-amd64.tar.gz"
    sha256 "48bff92d3e78324ce53d0e73243afbc6472b26b67a534a8a1a140a09d0eee277"
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
