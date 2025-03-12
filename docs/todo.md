# airu install 実装 TODO リスト

## 基本機能の実装

### bin/airu の更新
- [ ] `init` コマンドを追加
  - [ ] `.airu` ディレクトリを作成する機能
  - [ ] デフォルトの `Airfile` を作成する機能
  - [ ] デフォルトの `config.yml` を作成する機能（オプション）
- [ ] `install` メソッドを更新
  - [ ] カレントディレクトリに `.airu` フォルダが存在するか確認
  - [ ] `.airu` フォルダが存在しない場合、`airu init` を実行するよう促すメッセージを表示
  - [ ] `.airu/Airfile` を読み込む機能
  - [ ] Airfile に記載されている AI ルールを解析する機能
  - [ ] 指定された AI ルールを適切な場所にコピーする機能

### サンプル AI ルールの作成
- [ ] `ai-rules` ディレクトリを作成
- [ ] サンプルルール1: `project-rule` の作成
  - [ ] `ai-rules/project-rule/rule.md` ファイルの作成
  - [ ] サンプル例の作成
- [ ] サンプルルール2: `command-rule` の作成
  - [ ] `ai-rules/command-rule/rule.md` ファイルの作成
  - [ ] サンプル例の作成
- [ ] サンプルルール3: `code-review-rule` の作成
  - [ ] `ai-rules/code-review-rule/rule.md` ファイルの作成
  - [ ] サンプル例の作成

## テストと検証
- [ ] `airu init` コマンドのテスト
  - [ ] `.airu` ディレクトリが正しく作成されることを確認
  - [ ] デフォルトファイルが正しく作成されることを確認
- [ ] `airu install` コマンドのテスト
  - [ ] `.airu` が存在しない場合のメッセージ表示を確認
  - [ ] Airfile から正しく AI ルールを読み込めることを確認
  - [ ] AI ルールが正しくコピーされることを確認

## ドキュメント
- [ ] README.md の更新
  - [ ] `airu init` コマンドの使用方法を追加
  - [ ] `airu install` コマンドの詳細な説明を追加
  - [ ] Airfile の書き方の説明を追加
- [ ] ヘルプメッセージの更新
  - [ ] `init` コマンドの説明を追加 
