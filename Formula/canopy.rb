# typed: false
# frozen_string_literal: true

# Canopy - AI Development Platform
# One install: LLM proxy (Cambium) + AI memory (Phloem)
class Canopy < Formula
  desc "AI development platform - smart routing + persistent memory"
  homepage "https://github.com/CanopyHQ/canopy"
  version "0.5.3-beta"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/CanopyHQ/canopy-releases/releases/download/v0.5.3-beta/canopy-0.5.3-beta-darwin-arm64.tar.gz"
    sha256 "a1e132492d8db24dac3b469c1269ce60cf961592534091ba8f3ef7407c357604"
  else
    url "https://github.com/CanopyHQ/canopy-releases/releases/download/v0.5.3-beta/canopy-0.5.3-beta-darwin-amd64.tar.gz"
    sha256 "ca352f1aca568b5913ce4a87fa2f1a41f42b9f376564f155c7187e9fa5559077"
  end

  def install
    bin.install "cambium"
    bin.install "phloem"
    
    # Install unified CLI wrapper
    (bin/"canopy").write <<~EOS
      #!/bin/bash
      case "$1" in
        proxy|keys|price|policy)
          exec "$(dirname "$0")/cambium" "$@"
          ;;
        remember|recall|forget|status|license|upgrade|serve)
          exec "$(dirname "$0")/phloem" "$@"
          ;;
        setup)
          echo "🌳 Canopy Setup"
          echo "==============="
          echo ""
          echo "Step 1: Setting up API keys..."
          "$(dirname "$0")/cambium" keys setup
          echo ""
          echo "Step 2: Configuring Cursor MCP..."
          mkdir -p ~/.cursor
          if [ ! -f ~/.cursor/mcp.json ]; then
            echo '{"mcpServers":{"phloem":{"command":"#{HOMEBREW_PREFIX}/bin/phloem","args":["serve"]}}}' > ~/.cursor/mcp.json
            echo "✅ Created ~/.cursor/mcp.json"
          else
            echo "⚠️  ~/.cursor/mcp.json exists - add phloem manually if needed"
          fi
          echo ""
          echo "✅ Canopy is ready!"
          echo ""
          echo "Next steps:"
          echo "  1. Restart Cursor (for Phloem memory)"
          echo "  2. Run: cambium proxy start"
          echo "  3. Configure tools to use http://localhost:7777/v1"
          ;;
        version|--version|-v)
          echo "Canopy v0.5.1-beta"
          echo "  Cambium $(cambium version 2>&1 | head -1)"
          echo "  Phloem $(phloem version 2>&1 | head -1)"
          ;;
        help|--help|-h|"")
          echo "🌳 Canopy - AI Development Platform"
          echo ""
          echo "Usage: canopy <command>"
          echo ""
          echo "Setup:"
          echo "  canopy setup           # One-time setup wizard"
          echo ""
          echo "Cambium (LLM Proxy - saves 70% on API costs):"
          echo "  canopy proxy start     # Start the proxy"
          echo "  canopy price <model>   # Compare model prices"
          echo "  canopy keys setup      # Configure API keys"
          echo ""
          echo "Phloem (AI Memory - your AI remembers):"
          echo "  canopy remember <text> # Store a memory"
          echo "  canopy recall <query>  # Search memories"
          echo "  canopy status          # Memory stats"
          echo ""
          echo "Direct access:"
          echo "  cambium --help         # Full Cambium CLI"
          echo "  phloem --help          # Full Phloem CLI"
          ;;
        *)
          echo "Unknown command: $1"
          echo "Run 'canopy help' for usage"
          exit 1
          ;;
      esac
    EOS
  end

  def caveats
    <<~EOS
      🌳 Canopy is installed!

      Run the setup wizard:
        canopy setup

      Or start manually:
        cambium keys setup       # Add your API keys
        cambium proxy start      # Start proxy on :7777
        
      Then configure your tools:
        export OPENAI_BASE_URL="http://localhost:7777/v1"

      For Cursor IDE, add to ~/.cursor/mcp.json:
        {
          "mcpServers": {
            "phloem": {
              "command": "#{HOMEBREW_PREFIX}/bin/phloem",
              "args": ["serve"]
            }
          }
        }

      What you get (FREE):
        • 70% savings on LLM API costs
        • AI that remembers across sessions
        • Works with Claude, GPT, Gemini, Llama, 360+ models

      Docs: https://github.com/CanopyHQ/canopy
    EOS
  end

  test do
    assert_match "cambium", shell_output("#{bin}/cambium version 2>&1")
    assert_match "phloem", shell_output("#{bin}/phloem version 2>&1")
  end
end
