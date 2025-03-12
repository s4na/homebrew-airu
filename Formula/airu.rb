class Airu < Formula
  desc "AIルールマネージャー"
  homepage "https://github.com/s4na/homebrew-airu"
  url "https://github.com/s4na/homebrew-airu/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000" # 実際のリリース時に更新する必要があります
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "bin/airu"
  end

  test do
    system "#{bin}/airu", "help"
  end
end 
