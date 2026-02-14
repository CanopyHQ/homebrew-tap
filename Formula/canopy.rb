class Canopy < Formula
  desc "AI Memory Layer - Persistent context for your AI tools"
  homepage "https://canopyhq.io"
  version "0.6.1-beta"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/CanopyHQ/canopy-releases/releases/download/v0.6.1-beta/canopy-darwin-arm64.tar.gz"
      sha256 "d0f916be32c4bdf682e8e87f8458e00d309c42cf6d6227db233a6443929b564f"
    else
      url "https://github.com/CanopyHQ/canopy-releases/releases/download/v0.6.1-beta/canopy-darwin-amd64.tar.gz"
      sha256 "028d7370534a570a68ae45aed79e47fcc7e728a7617cd6ed85abf252b2a883f9"
    end
  end

  def install
    bin.install "canopy"
  end

  test do
    assert_match "Phloem", shell_output("#{bin}/canopy --help")
  end

  def caveats
    <<~EOS
      🌳 Canopy v0.6.1-beta is installed!

      Your AI memories travel with you across tools.

      Quick setup for agentic IDE tools (Cursor, Windsurf):
        Add to ~/.cursor/mcp.json or ~/.windsurf/mcp.json:
        {
          "mcpServers": {
            "phloem": {
              "command": "#{opt_bin}/canopy",
              "args": ["serve"]
            }
          }
        }

      Commands:
        canopy serve    - Start MCP server
        canopy status   - View memory stats
        canopy graft    - Export/import memory grafts
        canopy help     - Full command list

      Documentation: https://canopyhq.io/docs
    EOS
  end
end
