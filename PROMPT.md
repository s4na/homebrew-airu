# PROMPT

---

## 2024-03-12: Homebrewのtapプロジェクト作成

- Homebrewのtapプロジェクト構造を作成
  - `Formula/airu.rb`: Homebrewのフォーミュラファイル
  - `bin/airu`: airuコマンドの実装
- airuコマンドの基本機能
  - インストール、更新、一覧表示、ヘルプの基本コマンドを実装
  - `~/.airu/rules` ディレクトリにAIルールを保存する設計
- 今後の課題
  - 実際のリリース時にはsha256ハッシュを更新する必要あり
  - AIルールのインストール・更新ロジックの詳細実装

---

## 2024-03-12: Homebrewのtapプロジェクト完成

- Homebrewのtapプロジェクトを完成
  - Formula/airu.rbファイルを修正
  - リリースタグの作成準備
- インストール手順
  - `brew tap s4na/homebrew-airu`
  - `brew install airu`
  - `airu` コマンドで実行可能
- 今後の作業
  - リリースタグを作成してGitHubにプッシュ
  - sha256ハッシュを実際の値に更新
  - AIルールのインストール・更新ロジックの実装

---

## 2024-03-12: Homebrewでのインストール確認

- SHA256ハッシュを実際の値に更新
  - `088c5683bb86cf32148ccd1dc57f99aaced2941fb5b5dfe5b9f15c22730843d8`
- インストールの確認
  - `brew tap s4na/homebrew-airu` が成功
  - `brew install airu` が成功
  - `airu` コマンドが正常に実行可能
- 今後の課題
  - AIルールのインストール・更新ロジックの詳細実装
  - READMEのTODOリストの実装

---

## 2024-03-12: airuコマンドの動作変更

- airuコマンドの動作を変更
  - 引数なしで実行した場合は `install` コマンドと同じ動作をするように変更
  - ヘルプは `-h` または `--help` オプションで表示するように変更
- コマンドの使い方
  - `airu` - AIルールをインストール
  - `airu -h` - ヘルプを表示
  - `airu update` - AIルールを更新
  - `airu list` - インストール済みのAIルールを表示
