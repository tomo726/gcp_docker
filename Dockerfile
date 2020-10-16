# 動かし方
# docker build -t flask_docker .
# ローカルコンテナ: docker run -e PORT=8000 -p 8000:8000 flask_docker
# サーバコンテナ: 
# tagも毎回付け直す必要がある
# docker tag flask_docker gcr.io/integral-cell-280701/flask_docker
# docker push gcr.io/integral-cell-280701/flask_docker

# 編集
# 1. docker build -t flask_docker .
# 2.1. docker run -i -t -p 8000:8000 flask_docker /bin/bash で編集
# 2.2. docker container cp ローカルファイル [コンテナID]:/app で　ローカルト->コンテナにファイル移動
# 3. 別のタブでdocker commit [コンテナID] flask_dockerを実行し、2.をexit

# コンテナ全削除
# docker ps -aq | xargs | docker rm -f

# イメージ全削除
# docker images -aq | xargs | docker rmi -f


# なぜdockerを使うのか
# OSやバージョン違いの動作に素早く対応できデプロイの速度を上げられるから

# Use the official Python image.
# https://hub.docker.com/_/python
FROM python:3.7

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . .

# RUNはbuild時に実行され、CMDはコンテナを立ち上げる (ローカルならdocker run、GCPならCloud Run)
# Install production dependencies.
RUN pip install Flask gunicorn


# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 app:app
