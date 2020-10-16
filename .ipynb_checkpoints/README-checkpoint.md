# GCPでDockerを使う

Dockerを使う理由:  
OSやバージョン違いの動作に素早く対応できデプロイの速度を上げられるから

## 簡略版 (ローカルにイメージを作らず直接GCPにアップ)
- 最初  
gcloud builds submit --tag gcr.io/celtic-fact-283407/helloworld  
gcloud run deploy --region=asia-northeast1 --image gcr.io/celtic-fact-283407/helloworld --platform managed  
- 編集      
「継続的デプロイを編集」によってgit pushをすれば自動で更新される  



## ローカルから細かく行う方法
- 最初  
docker build -t flask_docker .  
ローカルコンテナ: docker run -e PORT=8000 -p 8000:8000 flask_docker  
サーバコンテナ:  
tagも毎回付け直す必要がある  
docker tag flask_docker gcr.io/integral-cell-280701/flask_docker  
docker push gcr.io/integral-cell-280701/flask_docker  
- 編集  
1. docker build -t flask_docker .  
2.1. docker run -i -t -p 8000:8000 flask_docker /bin/bash で編集  
2.2. docker container cp ローカルファイル [コンテナID]:/app で　ローカルト->コンテナにファイル移動  
3. 別のタブでdocker commit [コンテナID] flask_dockerを実行し、2.をexit  
コンテナ全削除  
docker ps -aq | xargs docker rm -f  
イメージ全削除  
docker images -aq | xargs docker rmi -f  