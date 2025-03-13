require_relative 'test_helper'
require 'tmpdir'
require 'fileutils'
require 'yaml'

class ConfigTest < Minitest::Test
  include TestHelper

  def setup
    setup_temp_dir
  end

  def teardown
    cleanup_temp_dir
  end

  def test_config_file_creation
    # 設定ファイルを作成するコマンドを実行
    output, status = run_airu('config')
    
    assert status, "configコマンドが失敗しました"
    assert_match(/設定ファイルを初期化しています/, output)
    assert_match(/\.airu\.ymlファイルを作成しました/, output)
    assert_file_exists('.airu.yml')
    
    # 設定ファイルの内容を検証
    config = YAML.load_file('.airu.yml')
    assert_kind_of Hash, config
    assert config.key?('rules_dir'), "設定ファイルにrules_dirが含まれていません"
    assert config.key?('default_rules'), "設定ファイルにdefault_rulesが含まれていません"
  end

  def test_config_file_overwrite_confirmation
    # 既存の設定ファイルを作成
    File.open('.airu.yml', 'w') do |f|
      f.puts YAML.dump({
        'rules_dir' => '~/.custom_rules',
        'default_rules' => ['custom-rule']
      })
    end
    
    # 上書き確認で「いいえ」を選択
    output = simulate_stdin('n') do
      capture_stdout do
        Airu.new.config
      end
    end
    
    assert_match(/設定ファイルが既に存在します/, output)
    assert_match(/上書きしますか？/, output)
    
    # 設定ファイルが上書きされていないことを確認
    config = YAML.load_file('.airu.yml')
    assert_equal '~/.custom_rules', config['rules_dir']
    assert_equal ['custom-rule'], config['default_rules']
    
    # 上書き確認で「はい」を選択
    output = simulate_stdin('y') do
      capture_stdout do
        Airu.new.config
      end
    end
    
    assert_match(/設定ファイルが既に存在します/, output)
    assert_match(/上書きしますか？/, output)
    assert_match(/\.airu\.ymlファイルを作成しました/, output)
    
    # 設定ファイルが上書きされたことを確認
    config = YAML.load_file('.airu.yml')
    assert_equal File.expand_path('~/.airu/rules'), config['rules_dir']
    assert_includes config['default_rules'], 'project-rule'
  end

  def test_custom_config_values
    # 設定ファイルを作成
    File.open('.airu.yml', 'w') do |f|
      f.puts YAML.dump({
        'rules_dir' => File.join(@temp_dir, 'custom_rules'),
        'default_rules' => ['custom-rule-1', 'custom-rule-2']
      })
    end
    
    # カスタムルールディレクトリを作成
    custom_rules_dir = File.join(@temp_dir, 'custom_rules')
    FileUtils.mkdir_p(custom_rules_dir)
    
    # カスタムルールを作成
    ['custom-rule-1', 'custom-rule-2'].each do |rule_name|
      rule_dir = File.join(custom_rules_dir, rule_name)
      FileUtils.mkdir_p(rule_dir)
      
      File.open(File.join(rule_dir, 'rule.md'), 'w') do |f|
        f.puts "# Version: 1.0.0"
        f.puts "# #{rule_name}"
        f.puts ""
        f.puts "This is a test rule."
      end
    end
    
    # .airuファイルを作成
    File.open('.airu', 'w') do |f|
      f.puts "# AIルール設定ファイル"
      f.puts "custom-rule-1"
      f.puts "custom-rule-2"
    end
    
    # インストールコマンドを実行
    output, status = run_airu('install')
    
    assert status, "installコマンドが失敗しました"
    assert_match(/AIルールをインストールしています/, output)
    assert_match(/ルール 'custom-rule-1' をインストールしています/, output)
    assert_match(/ルール 'custom-rule-2' をインストールしています/, output)
    
    # インストールされたファイルを検証
    cursor_rules_dir = File.join(Dir.pwd, '.cursor', 'rules')
    assert Dir.exist?(cursor_rules_dir), ".cursor/rulesディレクトリが作成されていません"
    
    rule1_file = File.join(cursor_rules_dir, 'custom-rule-1.mdc')
    rule2_file = File.join(cursor_rules_dir, 'custom-rule-2.mdc')
    
    assert_file_exists(rule1_file)
    assert_file_exists(rule2_file)
  end

  def test_init_with_config
    # 設定ファイルを作成
    File.open('.airu.yml', 'w') do |f|
      f.puts YAML.dump({
        'rules_dir' => '~/.airu/rules',
        'default_rules' => ['project-rule', 'command-rule', 'custom-rule']
      })
    end
    
    # initコマンドを実行
    output, status = run_airu('init')
    
    assert status, "initコマンドが失敗しました"
    assert_match(/AIルール設定ファイルを初期化しています/, output)
    assert_match(/\.airuファイルを作成しました/, output)
    
    # .airuファイルの内容を検証
    content = File.read('.airu')
    assert_match(/project-rule/, content)
    assert_match(/command-rule/, content)
    assert_match(/custom-rule/, content)
  end
end 
