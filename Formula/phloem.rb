# typed: false
# frozen_string_literal: true

# Canopy - AI Memory Layer (Phloem)
# Local-first persistent memory for AI coding tools via MCP
class Phloem < Formula
  desc "AI Memory Layer - Persistent context for your AI tools"
  homepage "https://github.com/CanopyHQ/canopy"
  version "0.5.4-beta"
  license "Proprietary"

  if Hardware::CPU.arm?
    url "https://github.com/CanopyHQ/canopy/releases/download/v0.5.4-beta/canopy-darwin-arm64.tar.gz"
    sha256 "64a727129ada24111ad2bd13b299f5365b90b998d206756f1ed7d5da8be4d00c"
  else
    url "https://github.com/CanopyHQ/canopy/releases/download/v0.5.4-beta/canopy-darwin-amd64.tar.gz"
    sha256 "1d4f5c20d0fa3c9ef76960b2bf64529ca4e2d7cd9b25e137d719242a22bf6051"
  end

  def install
    bin.install "canopy"
  end

  def post_install
    # Create data directory
    (var/"phloem").mkpath
  end

  def caveats
    <<~EOS
      Canopy is installed! 🧠

      Quick Setup:
        canopy setup cursor      # Auto-configure Cursor IDE
        canopy setup windsurf    # Auto-configure Windsurf IDE

      Or manually add to ~/.cursor/mcp.json:
        {
          "mcpServers": {
            "phloem": {
              "command": "#{bin}/canopy",
              "args": ["serve"]
            }
          }
        }

      Then restart your IDE. Your AI now has persistent memory!

      Commands:
        canopy status            # Check memory status
        canopy doctor            # Diagnose setup issues
        canopy import chatgpt <file>  # Import ChatGPT history
        canopy import claude <dir>    # Import Claude history
        canopy help              # Full command list

      Documentation: https://github.com/CanopyHQ/canopy
    EOS
  end

  test do
    assert_match "canopy", shell_output("#{bin}/canopy version 2>&1")
  end
end
