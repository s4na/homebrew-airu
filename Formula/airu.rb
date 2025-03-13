class Airu < Formula
  desc "AIルールマネージャー"
  homepage "https://github.com/s4na/homebrew-airu"
  url "https://github.com/s4na/homebrew-airu/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "19bf318c7269a2e915da70a1c1ef5b9fa30bb8a29215037a7c7c9dcdd0b9bfe6"
  license "MIT"

  depends_on "ruby"

  def install
    bin.install "bin/airu"
  end

  def caveats
    <<~EOS
      airuコマンドはカレントディレクトリに .airu ディレクトリを作成します。
      設定ファイル(.airu.yml)を使用して、ルールディレクトリのパスをカスタマイズできます。
      利用可能なAIルール: project-rule, command-rule, code-review-rule
    EOS
  end

  test do
    system "#{bin}/airu", "-h"
  end
end 
