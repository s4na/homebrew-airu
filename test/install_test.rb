require_relative 'test_helper'
require 'tmpdir'

class InstallTest < Minitest::Test
  include TestHelper

  def setup
    setup_temp_dir
  end

  def teardown
    cleanup_temp_dir
  end

  def test_install_shows_error_when_airu_file_not_exists
    output, status = run_airu('install')
    
    assert status, "コマンドが失敗しました"
    assert_match(/エラー: \.airuファイルが見つかりません/, output)
    assert_match(/airu initコマンドを実行して\.airuファイルを作成してください/, output)
  end

  def test_install_shows_warning_for_empty_airu_file
    # 空の.airuファイルを作成
    File.write('.airu', "")
    
    output, status = run_airu('install')
    
    assert status, "コマンドが失敗しました"
    assert_match(/警告: \.airuファイルにルールが指定されていません/, output)
  end

  def test_install_shows_warning_for_comments_only_airu_file
    # コメントのみの.airuファイルを作成
    File.write('.airu', "# This is a comment\n# Another comment")
    
    output, status = run_airu('install')
    
    assert status, "コマンドが失敗しました"
    assert_match(/警告: \.airuファイルにルールが指定されていません/, output)
  end

  def test_install_processes_rules_from_airu_file
    # ルールが記載された.airuファイルを作成
    File.write('.airu', <<~CONTENT
      # AIルール設定ファイル
      project-rule
      command-rule
    CONTENT
    )
    
    output, status = run_airu('install')
    
    assert status, "コマンドが失敗しました"
    assert_match(/AIルールをインストールしています/, output)
    assert_match(/ルール 'project-rule' をインストールしています/, output)
    assert_match(/ルール 'command-rule' をインストールしています/, output)
    assert_match(/インストール完了！/, output)
  end

  def test_install_ignores_empty_lines_and_comments
    # 空行とコメントを含む.airuファイルを作成
    File.write('.airu', <<~CONTENT
      # AIルール設定ファイル
      
      # これはコメントです
      project-rule
      
      command-rule
      # これもコメントです
    CONTENT
    )
    
    output, status = run_airu('install')
    
    assert status, "コマンドが失敗しました"
    assert_match(/ルール 'project-rule' をインストールしています/, output)
    assert_match(/ルール 'command-rule' をインストールしています/, output)
    refute_match(/これはコメント/, output)
  end

  def test_install_handles_permission_error
    # ルールが記載された.airuファイルを作成
    File.write('.airu', "test-rule")
    
    # .cursorディレクトリを作成して権限を制限
    FileUtils.mkdir_p('.cursor')
    FileUtils.chmod(0000, '.cursor') # 読み取り/書き込み/実行権限をすべて削除
    
    begin
      output, status = run_airu('install')
      
      assert status, "コマンドが失敗しました"
      assert_match(/AIルールをインストールしています/, output)
      assert_match(/ルール 'test-rule' をインストールしています/, output)
      assert_match(/エラー: ルール 'test-rule' のインストール中にエラーが発生しました/, output)
    ensure
      # テスト後に権限を元に戻す
      FileUtils.chmod(0755, '.cursor')
    end
  end

  def test_install_handles_corrupted_airu_file
    # 破損した.airuファイルを模擬（バイナリデータを含む）
    File.open('.airu', 'wb') do |f|
      f.write("valid-rule\n\x00\x01\x02\nproject-rule")
    end
    
    output, status = run_airu('install')
    
    assert status, "コマンドが失敗しました"
    assert_match(/AIルールをインストールしています/, output)
    assert_match(/ルール 'valid-rule' をインストールしています/, output)
    # バイナリデータは無視されるか、エラーが発生しても処理が続行されることを確認
    assert_match(/ルール 'project-rule' をインストールしています/, output)
  end
end 
