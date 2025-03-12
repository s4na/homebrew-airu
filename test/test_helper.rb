require 'minitest/autorun'
require 'minitest/pride'
require 'fileutils'
require 'stringio'
require 'tmpdir'

# bin/airuのパスを取得
BIN_PATH = File.expand_path('../bin/airu', __dir__)

# Airuクラスを読み込む
load BIN_PATH

# テスト用のヘルパーモジュール
module TestHelper
  # テスト用の一時ディレクトリを作成
  def setup_temp_dir
    @temp_dir = File.join(Dir.tmpdir, "airu_test_#{Time.now.to_i}")
    FileUtils.mkdir_p(@temp_dir)
    @original_dir = Dir.pwd
    Dir.chdir(@temp_dir)
  end

  # テスト用の一時ディレクトリを削除
  def cleanup_temp_dir
    Dir.chdir(@original_dir)
    FileUtils.rm_rf(@temp_dir) if @temp_dir && Dir.exist?(@temp_dir)
  end

  # 標準入力をモック化
  def simulate_stdin(*inputs)
    io = StringIO.new
    inputs.flatten.each { |input| io.puts(input) }
    io.rewind
    
    original_stdin = $stdin
    $stdin = io
    yield
  ensure
    $stdin = original_stdin
  end

  # 標準出力をキャプチャ
  def capture_stdout
    original_stdout = $stdout
    io = StringIO.new
    $stdout = io
    yield
    io.string
  ensure
    $stdout = original_stdout
  end

  # airuコマンドを実行
  def run_airu(args = '')
    output = `ruby #{BIN_PATH} #{args} 2>&1`
    [output, $?.success?]
  end

  # ファイルの内容を検証
  def assert_file_content(file_path, expected_content)
    assert File.exist?(file_path), "ファイル #{file_path} が存在しません"
    content = File.read(file_path)
    assert_equal expected_content, content
  end

  # ファイルの存在を検証
  def assert_file_exists(file_path)
    assert File.exist?(file_path), "ファイル #{file_path} が存在しません"
  end

  # ファイルの非存在を検証
  def assert_file_not_exists(file_path)
    refute File.exist?(file_path), "ファイル #{file_path} が存在します"
  end
end 
