# typed: false
# frozen_string_literal: true

# Phloem - Local-first AI Memory with Causal Graphs
# Persistent context for AI coding tools via MCP
class Phloem < Formula
  desc "Local-first AI memory with causal graphs via MCP"
  homepage "https://github.com/CanopyHQ/phloem"
  version "1.0.0"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/CanopyHQ/phloem/releases/download/v1.0.0/phloem-darwin-arm64.tar.gz"
    sha256 "f1392cf02895fec6722b6069a9e72e601677fc0a8b66846588c13d302c160ff3"
  else
    url "https://github.com/CanopyHQ/phloem/releases/download/v1.0.0/phloem-darwin-amd64.tar.gz"
    sha256 "7a2834b0b20953f16ba0427f6273ebf004b35c1b91f13bd0700c15332f8d86b1"
  end

  def install
    bin.install "phloem"
  end

  def post_install
    (var/"phloem").mkpath
  end

  def caveats
    <<~EOS
      Phloem v1.0.0 installed!

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
