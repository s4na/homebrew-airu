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
- `update` - AIルールを更新します（将来的な機能）
- `list` - インストール済みのAIルールを表示します（将来的な機能）
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
- [x] 特定のルールを選んでインポートできるようにする
  - [x] `.airu`ファイルで、使用するルールを指定できるようにする

## AIルールのTODO
- [ ] / 系の特別なコマンドのルールは / コマンドを入力されたら読子おむようにする
- [ ] `airu-*` ってファイル名にして、 `airu` で作成したファイルかどうか判断できるようにする
  - [ ] airu コマンド使ったら、 .gitignore に `**/airu-*` を追加する
- [x] `.airu` ファイルの中にどういうAIルールを使ってるか定義知るようにする
- [ ] タスクの粒度を記載する
- [ ] プログラム以外の場合、どうやってテストコード的なものを実装するのか、考えないと
  - [ ] 別のAIにテストさせられたら一番いいんだけど（じゃないと自分で書いたものだから、AIが自分で自分を擁護しちゃうはず）

## ライセンス

MIT
