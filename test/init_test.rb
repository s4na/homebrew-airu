require_relative 'test_helper'
require 'tmpdir'

class InitTest < Minitest::Test
  include TestHelper

  def setup
    setup_temp_dir
  end

  def teardown
    cleanup_temp_dir
  end

  def test_init_creates_airu_file_when_not_exists
    output, status = run_airu('init')
    
    assert status, "コマンドが失敗しました"
    assert_match(/AIルール設定ファイルを初期化しています/, output)
    assert_match(/\.airuファイルを作成しました/, output)
    assert_file_exists('.airu')
    
    content = File.read('.airu')
    assert_match(/# AIルール設定ファイル/, content)
    assert_match(/# 各行に使用するルールを記述してください/, content)
  end

  def test_init_asks_for_confirmation_when_file_exists
    # 既存の.airuファイルを作成
    File.write('.airu', "existing content")
    
    # 'n'を入力してキャンセル
    output = simulate_stdin('n') do
      capture_stdout do
        Airu.new.run(['init'])
      end
    end
    
    assert_match(/警告: \.airuファイルが既に存在します/, output)
    assert_equal "existing content", File.read('.airu')
    
    # 'y'を入力して上書き
    output = simulate_stdin('y') do
      capture_stdout do
        Airu.new.run(['init'])
      end
    end
    
    assert_match(/警告: \.airuファイルが既に存在します/, output)
    assert_match(/\.airuファイルを作成しました/, output)
    
    content = File.read('.airu')
    assert_match(/# AIルール設定ファイル/, content)
  end

  def test_created_airu_file_has_correct_content
    run_airu('init')
    
    content = File.read('.airu')
    expected_content = <<~CONTENT
      # AIルール設定ファイル
      # 各行に使用するルールを記述してください
      # 例:
      # project-rule
      # command-rule
    CONTENT
    
    assert_equal expected_content, content
  end

  # ファイルシステム操作をモック化したテスト
  def test_init_with_file_system_mock
    # ファイル存在チェックをモック
    File.stub(:exist?, false) do
      # ファイル書き込みをモック
      file_mock = StringIO.new
      
      # File.openをスタブ化して、ブロックにfile_mockを渡す
      File.stub(:open, nil, file_mock) do
        output = capture_stdout do
          # initメソッドを直接呼び出す
          airu = Airu.new
          airu.init
        end
        
        # 出力メッセージを検証
        assert_match(/AIルール設定ファイルを初期化しています/, output)
        assert_match(/\.airuファイルを作成しました/, output)
      end
    end
  end

  # ユーザー入力をスタブ化したテスト
  def test_init_with_user_input_stub
    # 既存の.airuファイルを作成
    File.write('.airu', "existing content")
    
    # ユーザー入力をスタブ化
    output = simulate_stdin('y') do
      capture_stdout do
        airu = Airu.new
        airu.init
      end
    end
    
    # 出力メッセージを検証
    assert_match(/警告: \.airuファイルが既に存在します/, output)
    assert_match(/\.airuファイルを作成しました/, output)
    
    # ファイルが上書きされたことを確認
    content = File.read('.airu')
    assert_match(/# AIルール設定ファイル/, content)
    refute_match(/existing content/, content)
  end
end 
