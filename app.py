# gunicornによるwsgiサーバはPHPに対するapacheみたいなもの 
# htmlファイルはtemplatesの中に入れないと動かない
from flask import Flask, render_template
import os
import subprocess
 



# app = Flask(__name__)
# デフォルトでhtmlからアクセスできるフォルダはstaticという名前でなければいけないため以下のように変更
app = Flask(__name__, static_folder='')


# 関数名が同じだとエラーが出る
# @app.route("/<name>")
# def hello_world(name):
#     return render_template('sample.html', name=name)

# @app.route("/")
# def image_list():
#     image_list = os.listdir('image_sample')
#     # .remove()で最初の一個を消す  <- gcpだと.gcloudignoreに記述しているので.ipynb_checkpointが最初から消されている
#     image_list.remove('.ipynb_checkpoints')
#     url_list = ['image_sample/' + image for image in image_list]
#     return render_template('untitled.html', url_list=url_list)

# @app.route('/untitled2.com')
# def sample():
#     return render_template('untitled2.html')


# 外部のリポジトリを含む際には.gitファイルを消してディレクトリ名を変更する必要あり (そうしないとディレクトリに白い矢印マークが現れる)
@app.route("/")
def markdown():
    return render_template("untitled2.html")


@app.route("/pos_neg/<text>")
def pos_neg(text):
    text = 'You just make me so sad and I have to leave you .'
    cmd = ['python', './cnn-text-classification-pytorch/main.py', '-predict', text, '-snapshot', './cnn-text-classification-pytorch/snapshot/2020-10-17_17-26-19/best_steps_2200.pt']
    runcmd = subprocess.run(cmd, encoding='utf-8', stdout=subprocess.PIPE)
    runcmd2 = subprocess.run(['ls'], encoding='utf-8', stdout=subprocess.PIPE)
#     sentiment = runcmd.stdout.split()[-1]
    sentiment = runcmd.stdout
    return '<br>\n' + text + ' の感情は: ' + sentiment + runcmd2.stdout


# 127.0.0.1(=localhost)はループバックアドレス(自分しか見れない)
# 0.0.0.0はワイルドカード, LAN内のすべてのIPに対してポートを開放している
if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080)))
    # app.run(host='0.0.0.0')