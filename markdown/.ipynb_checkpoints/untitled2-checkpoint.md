# List of code and paper
以下のコマンドを実行するとmdファイルからhtmlファイルに変換できる。LaTeXにも変換可能。  
```
pandoc -f markdown -t html --template templates/md2html.html markdown/untitled2.md > templates/untitled2.html
```
## code
[GCPにDockerを上げてWebサイトを公開](https://github.com/tomo726/gcp_docker)

[画像スクレイピング等におけるseleniumの使い方](https://github.com/tomo726/selenium_usage)

## paper
[Is BERT Really Robust? A Strong Baseline for Natural Language Attack on Text Classification and Entailment [Jin+, 2020]](https://arxiv.org/pdf/1907.11932.pdf)  
Bertに対するadversarial textをblackboxとして(中身を知らない状態で)作る研究で、次のステップで変更する単語を見つける  
Step1: Word Importance Ranking (予測の上で重要な単語を取り出す)  
Step2: Word Transfer (以下の３つを満たすなら単語を入れ替える)

- embedding空間で近いものN個を取り出す  
- 品詞が一致しているかチェック
- Universal Sentence Encoder (USE) (Cer et al. 2018)を使って文をベクトル化し、単語を入れ替える前後で大きく意味(ベクトル)が変化していないかチェック
