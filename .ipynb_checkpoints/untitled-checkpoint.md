# マークダウン -> LaTeX, html
mdファイルのあるところで、以下のコマンドを実行するとmdファイルをhtmlに変換できる、LaTeXへの変換も同様

## コードブロック
```
pandoc -f markdown -t html --template templates/md2html.html untitled.md > templates/[htmlファイル]
```

## テーブル
| Left align | Right align | Center align |
|:-----------|------------:|:------------:|
| This       |        This |     This     |
| column     |      column |    column    |
| will       |        will |     will     |
| be         |          be |      be      |
| left       |       right |    center    |
| aligned    |     aligned |   aligned    |

## 引用
> 結構頑張ったぽい?

## 箇条書きリスト
- りんご
- ごはん

## リスト
1. あ
2. い

## イタリック・太字
*イタリック*  
**太字**


## リンク
[Yahoo](http://www.yahoo.co.jp)

## 取り消し線
~~取り消し~~

## 画像

![サンプル](image_sample/ナルト_2.jpg)

