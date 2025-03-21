# バージョン履歴

## v0.1.7 (現在のバージョン)
- 追加AIルールの作成
  - `code-review-rule`を追加
    - コードレビューを支援するためのルール
    - `/review`、`/focus`、`/summary`などのコマンドをサポート
  - READMEの更新
    - 利用可能なAIルールの一覧に`code-review-rule`を追加

## v0.1.6
- 設定ファイル(`.airu.yml`)のサポートを追加
  - `airu config`コマンドで設定ファイルを作成
  - ルールディレクトリのカスタマイズが可能に
  - デフォルトルールの設定が可能に
  - 既存の設定ファイルの上書き確認機能
- ルールディレクトリのパスをホームディレクトリ(`~/.airu/rules`)に戻す
  - 設定ファイルで任意のパスを指定可能に
- READMEの更新
  - 設定ファイルの使用方法を追加
  - 新しいコマンドの説明を追加

## v0.1.5
- ルールのバージョン管理機能を実装
  - ルールファイル内の `# Version: x.y.z` 形式のバージョン情報を検出
  - `./.airu/versions.yml` ファイルでバージョン情報を管理
  - `airu update` コマンドでルールの更新が必要かどうかを判断
  - `airu list` コマンドでインストール済みルールとバージョン情報を表示

## v0.1.4
- ルールの保存場所をホームディレクトリ(`~/.airu/rules`)からカレントディレクトリ(`./.airu/rules`)に変更
  - プロジェクトごとにルールを管理できるように改善
  - 以前のバージョンで作成された`~/.airu`ディレクトリは手動で削除する必要あり
- `caveats`メソッドを追加して、バージョン更新時の注意事項を表示

## v0.1.3
- `install_rule`メソッドの実装
  - ルールの存在確認機能
  - ルールを適切な場所にコピーする機能
  - エラーハンドリング機能
- サンプルAIルールの計画
  - `project-rule`の設計
  - `command-rule`の設計
  - 注意: 実際のサンプルルールはリポジトリに含まれていません
- テストの拡充
  - エッジケースのテスト追加
  - モック/スタブを使ったテスト追加
- ドキュメントの更新
  - READMEの充実
  - ヘルプメッセージの改善

## v0.1.2
- `.airu`ファイルを使用するように変更
  - `Airfile`の代わりに`.airu`ファイルを使用
  - `.airu`はディレクトリではなくファイルとして実装
- `airu init`コマンドの追加
  - デフォルトの`.airu`ファイルを作成する機能
- `airu install`の改善
  - `.airu`ファイルからAIルールを読み込む機能
  - 指定されたAIルールをインストールする機能

## v0.1.1
- Homebrewでインストール可能に
- 基本的なコマンド構造の実装
  - `airu`: デフォルトでインストールを実行
  - `airu install`: AIルールをインストール
  - `airu update`: AIルールを更新
  - `airu list`: インストール済みのAIルールを表示
  - `airu help`: ヘルプを表示

## v0.1.0
- 初期リリース
- Homebrewタップの作成
- 基本的なコマンドラインインターフェースの実装
