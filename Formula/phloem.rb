# typed: false
# frozen_string_literal: true

# Phloem - AI Memory Layer
class Phloem < Formula
  desc "AI memory layer with semantic search - your AI finally remembers"
  homepage "https://github.com/CanopyHQ/canopy"
  version "0.2.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/CanopyHQ/canopy/releases/download/v0.2.0/phloem-darwin-arm64.tar.gz"
    sha256 "d49e0b93b0229bdc87b26759fcda4bda717f7562cf1804a8588b200c71344cbd"
  else
    url "https://github.com/CanopyHQ/canopy/releases/download/v0.2.0/phloem-darwin-amd64.tar.gz"
    sha256 "c77f72c87df44199f8bc954ea288d660e100214cdfc30fcaff507b621bff78cf"
  end

  def install
    bin.install "phloem-cli" => "phloem"
  end

  def post_install
    # Create data directory
    (var/"phloem").mkpath
  end

  def caveats
    <<~EOS
      Phloem is installed! 🧠

      Quick Start:
        phloem status              # Check memory status
        phloem license             # View license info
        phloem upgrade             # Upgrade to Pro ($9/mo)

      Configure Cursor IDE:
        Add to ~/.cursor/mcp.json:
        {
          "mcpServers": {
            "phloem": {
              "command": "#{bin}/phloem",
              "args": ["serve"]
            }
          }
        }

      Then restart Cursor.

      Documentation: https://github.com/CanopyHQ/canopy/tree/main/phloem
    EOS
  end

  test do
    assert_match "phloem", shell_output("#{bin}/phloem version 2>&1", 1)
  end
end
