# GCPでDockerを使う

Dockerを使う理由:  
OSやバージョン違いの動作に素早く対応できデプロイの速度を上げられるから  

## 簡略版 (ローカルにイメージを作らず直接Cloud Runにアップ)
- 最初  
```
gcloud builds submit --tag gcr.io/celtic-fact-283407/helloworld  
gcloud run deploy --region=asia-northeast1 --image gcr.io/celtic-fact-283407/helloworld --platform managed  
```
- 編集      
「継続的デプロイを編集」によってgit pushをすれば自動で更新される  

## Compute Engineでサーバ側のエラーチェック(.gitに注意すればローカルのDockerで代用可)
Cloud Runの補助として、sshでインスタンス内部に入り動作確認したり、GPUを使って学習する方法。  
container repositoryからGCEにデプロイを選択し、Cloud Engineのインスタンスにsshし以下のコマンドを実行。  
`
docker run -i -t -e PORT=8080 -p 8080:8080 bce5cedefa07 /bin/bash
`
## ローカルから細かく行う方法 (不要)
- 最初  
`docker build -t flask_docker .`  
ローカルコンテナの実行:    
`docker run -e PORT=8000 -p 8000:8000 flask_docker`  

サーバにコンテナを上げる:    
tagも毎回付け直す必要がある  
```
docker tag flask_docker gcr.io/integral-cell-280701/flask_docker  
docker push gcr.io/integral-cell-280701/flask_docker  
```
- 編集
1. docker build -t flask_docker .  
2. docker run -i -t -p 8000:8000 flask_docker /bin/bash で編集  
3. docker container cp ローカルファイル [コンテナID]:/app で　ローカルト->コンテナにファイル移動  
4. 別のタブでdocker commit [コンテナID] flask_dockerを実行し、2.をexit  
コンテナ全削除  
docker ps -aq | xargs docker rm -f  
イメージ全削除  
docker images -aq | xargs docker rmi -f  


## GPUを使う方法
IAMと管理->割り当てからcompute engineのT4とall regionsを１つづつ申請する  
Container RepositoryからGCEで開いてGPUの設定を行う  
不定期に(原因不明で)エラーが出てインスタンスを起動できない(一度に存在できるGPUが１つまでという設定だから?) 
ubuntuを使うとちゃんとドライバとcudaをインストールできた  
GPUを使わなくてもGCEは高め  
-> AI Platformを使う
