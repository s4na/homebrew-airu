# airu install 機能設計書

## 機能概要
`airu install` コマンドは、プロジェクト内で使用する AI ルールをインストールするための機能です。このコマンドは、プロジェクトのルートディレクトリにある `.airu` フォルダを検索し、そこに定義されている AI ルールを適切な場所にコピーします。

## 詳細設計

### `.airu` フォルダ構造
```
.airu/
  ├── Airfile    # 必要な AI ルールを Gemfile 形式で記述
  └── config.yml # 追加設定（オプション）
```

### Airfile 形式
```ruby
# 基本的な記述方法
rule "rule-name"
rule "another-rule"

# バージョン指定（将来的な拡張）
rule "rule-name", "1.0.0"
```

### AI ルールの配置場所
AI ルールは以下の構造で配置されます：
```
ai-rules/
  ├── rule-name/
  │   ├── rule.md
  │   └── examples/
  │       └── example.md
  ├── another-rule/
  │   └── rule.md
  └── ...
```

### コマンドフロー
1. `airu install` コマンド実行
2. カレントディレクトリに `.airu` フォルダが存在するか確認
   - 存在しない場合：`airu init` コマンドを実行するよう促す
   - 存在する場合：処理を続行
3. `.airu/Airfile` を読み込み、必要な AI ルールを特定
4. 指定された AI ルールを `~/.airu/rules` から現在のプロジェクトの適切な場所にコピー

### `airu init` コマンド
新しく追加する `init` コマンドは、以下の処理を行います：
1. カレントディレクトリに `.airu` フォルダを作成
2. デフォルトの `Airfile` を作成
3. 必要に応じて `config.yml` も作成 
