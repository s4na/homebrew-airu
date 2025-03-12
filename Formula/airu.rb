class Airu < Formula
  desc "AIルールマネージャー"
  homepage "https://github.com/s4na/homebrew-airu"
  url "https://github.com/s4na/homebrew-airu/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "088c5683bb86cf32148ccd1dc57f99aaced2941fb5b5dfe5b9f15c22730843d8"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "bin/airu"
  end

  test do
    system "#{bin}/airu", "help"
  end
end 
