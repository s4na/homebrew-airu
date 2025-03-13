# homebrew-airu

airu = ai rules

AIルールを管理するためのシンプルなツールです。AIルールとは、AIアシスタントに特定の動作や知識を与えるための設定ファイルです。

## インストール

Homebrewを使ってインストールできます：

```
brew tap s4na/homebrew-airu
brew install airu
```

## 使い方

### 初期化

プロジェクトディレクトリで以下のコマンドを実行して、`.airu`ファイルを作成します：

```
airu init
```

このコマンドは、カレントディレクトリに`.airu`ファイルを作成します。既に`.airu`ファイルが存在する場合は、上書きするかどうか確認されます。

### 設定ファイル

プロジェクトの設定を管理するために、`.airu.yml`設定ファイルを作成できます：

```
airu config
```

このコマンドは、カレントディレクトリに`.airu.yml`ファイルを作成します。既に`.airu.yml`ファイルが存在する場合は、上書きするかどうか確認されます。

設定ファイルには以下の項目を設定できます：

```yaml
# ルールディレクトリのパス
rules_dir: ~/.airu/rules

# デフォルトのルール（airu initで使用される）
default_rules:
  - project-rule
  - command-rule
```

- `rules_dir`: AIルールが保存されているディレクトリのパスを指定します。デフォルトは`~/.airu/rules`です。
- `default_rules`: `airu init`コマンドで作成される`.airu`ファイルに含まれるデフォルトのルールを指定します。

### AIルールの設定

`.airu`ファイルを編集して、使用したいAIルールを指定します：

```
# AIルール設定ファイル
# 各行に使用するルールを記述してください
project-rule
command-rule
```

各行に1つのルール名を記述します。`#`で始まる行はコメントとして扱われます。

### インストール

AIルールをインストールするには以下のコマンドを実行します：

```
airu install
```

または単に：

```
airu
```

このコマンドは、`.airu`ファイルに記載されているルールを読み込み、プロジェクトの`.cursor/rules/`ディレクトリにインストールします。

### 更新

インストール済みのAIルールを更新するには以下のコマンドを実行します：

```
airu update
```

このコマンドは、`.airu`ファイルに記載されているルールの最新バージョンをチェックし、必要に応じて更新します。

### ルールの一覧表示

インストール済みのAIルールとそのバージョン情報を表示するには以下のコマンドを実行します：

```
airu list
```

### ルールのバージョン管理

airuは、各ルールのバージョン情報を管理します。ルールファイル内に以下の形式でバージョン情報を記述することができます：

```
# Version: 1.0.0
```

この情報は、`airu update`コマンドで使用され、ルールの更新が必要かどうかを判断するために使用されます。

**注意**: v0.1.4からルールの保存場所がホームディレクトリ(`~/.airu/rules`)からカレントディレクトリ(`./.airu/rules`)に変更されました。以前のバージョンで作成された`~/.airu`ディレクトリは手動で削除する必要があります。

### ヘルプ

コマンドの使い方を確認するには：

```
airu help
```

または：

```
airu -h
```

### 利用可能なコマンド

- `init` - `.airu`ファイルを作成します
- `install` - AIルールをインストールします
- `update` - AIルールを更新します
- `list` - インストール済みのAIルールを表示します
- `config` - 設定ファイル(`.airu.yml`)を作成します
- `help` - ヘルプを表示します

## 利用可能なAIルール

現在、以下のAIルールが利用可能です：

- `project-rule` - プロジェクト固有の情報をAIに提供するためのルール
- `command-rule` - 特定のコマンドをAIに認識させるためのルール

## テスト

テストを実行するには：

```
rake test
```

## TODO
- [x] homebrew でインストールできるようにする
- [x] インストールしたら、 `$ airu` or `$ airu install` で更新できるようにしたい
  - bundler みたいな感じで
- [ ] 日本語で作ったルールを翻訳して英語で出力するようにする
- [ ] 特定のルールを選んでインポートできるようにする
  - [x] `.airu`ファイルで、使用するルールを指定できるようにする
  - [ ] サンプルAIルールをリポジトリに含める（`project-rule`や`command-rule`）
- [x] 設定ファイル(`.airu.yml`)のサポートを追加する

## AIルールのTODO
- [ ] / 系の特別なコマンドのルールは / コマンドを入力されたら読子おむようにする
- [ ] `airu-*` ってファイル名にして、 `airu` で作成したファイルかどうか判断できるようにする
  - [ ] airu コマンド使ったら、 .gitignore に `**/airu-*` を追加する
- [x] `.airu` ファイルの中にどういうAIルールを使ってるか定義知るようにする
- [ ] タスクの粒度を記載する
- [ ] プログラム以外の場合、どうやってテストコード的なものを実装するのか、考えないと
  - [ ] 別のAIにテストさせられたら一番いいんだけど（じゃないと自分で書いたものだから、AIが自分で自分を擁護しちゃうはず）
- [ ] 一旦流れてプラン、デザインドック、TODOってドキュメントを生成するようになってるけど、なんかもっとちゃんと整理したい
- [ ] AI向けのタスク管理が必要。コマンドで実行させたい。一緒にコミットさせたいので、できたらyamlとかで出力させたい

## ライセンス

MIT
