# homebrew-airu

airu = ai rules

## Usage

```
brew tap s4na/homebrew-airu
```

```
brew install airu
```

```
airu
```

## TODO
- [ ] homebrew でインストールできるようにする
- [ ] インストールしたら、 `$ airu` or `$ airu install` で更新できるようにしたい
  - bundler みたいな感じで
- [ ] 日本語で作ったルールを翻訳して英語で出力するようにする
- [ ] 特定のルールを選んでインポートできるようにする
  - [ ] 設定ファイルみたいなの作って、それの設定でインストールできるようにする

## AIルールのTODO
- [ ] / 系の特別なコマンドのルールは / コマンドを入力されたら読子おむようにする
- [ ] `airu-*` ってファイル名にして、 `airu` で作成したファイルかどうか判断できるようにする
  - [ ] airu コマンド使ったら、 .gitignore に `**/airu-*` を追加する
- [ ] `.airu` ファイルの中にどういうAIルールを使ってるか定義知るようにする
