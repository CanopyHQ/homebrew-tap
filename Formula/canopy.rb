class Canopy < Formula
  desc "AI Memory Layer - Persistent context for your AI tools"
  homepage "https://canopyhq.io"
  version "0.6.5-beta"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/CanopyHQ/canopy-releases/releases/download/v0.6.5-beta/canopy-darwin-arm64.tar.gz"
      sha256 "cf4a7a545a641d853be34e445a4dd39c87ec779f9338582749caa0f610e0415e"
    else
      url "https://github.com/CanopyHQ/canopy-releases/releases/download/v0.6.5-beta/canopy-darwin-amd64.tar.gz"
      sha256 "5cbc48f763fc67fe2d1836f80fc352f26e680561250851734df083daa5e2ec4f"
    end
  end

  def install
    bin.install "canopy"
  end

  test do
    assert_match "0.6.5-beta", shell_output("#{bin}/canopy version")
  end

  def caveats
    <<~EOS
      Canopy v#{version} is installed!

      Quick start:
        canopy setup          Auto-configure your IDE
        canopy setup cursor   Configure Cursor
        canopy setup claude-code  Configure Claude Code

      Commands:
        canopy serve    - Start MCP server
        canopy status   - View memory stats
        canopy support  - Get help
        canopy help     - Full command list

      Support: canopy support (or email support@canopyhq.io)
    EOS
  end
end

