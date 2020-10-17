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
RUN pip install numpy torch torchtext


# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 app:app
