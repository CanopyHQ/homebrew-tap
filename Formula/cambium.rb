# typed: false
# frozen_string_literal: true

# Cambium - LLM Proxy with Cost Optimization
class Cambium < Formula
  desc "LLM proxy with cost optimization and cross-provider price arbitrage"
  homepage "https://github.com/CanopyHQ/canopy"
  version "0.2.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/CanopyHQ/canopy/releases/download/v0.2.0/cambium-darwin-arm64.tar.gz"
    sha256 "ada7ad90ddde38a29f01df9ecf594809308e78197378d558a3fdf34d7efbd97f"
  else
    url "https://github.com/CanopyHQ/canopy/releases/download/v0.2.0/cambium-darwin-amd64.tar.gz"
    sha256 "d1c175cd5cf5d54455af4d5f13e5aa5a1ed8e1992d8d5c946e26e4fac2a85c05"
  end

  def install
    bin.install "cambium"
  end

  def caveats
    <<~EOS
      Cambium is installed! 🎉

      Quick Start:
        cambium keys setup          # Set up API keys interactively
        cambium proxy start         # Start the proxy on port 7777
        cambium price claude-3-5-sonnet  # Compare model prices

      Configure your tools:
        export OPENAI_BASE_URL="http://localhost:7777/v1"
        export ANTHROPIC_BASE_URL="http://localhost:7777/v1"

      Documentation: https://github.com/CanopyHQ/canopy/tree/main/cambium
    EOS
  end

  test do
    assert_match "cambium", shell_output("#{bin}/cambium version")
  end
end
