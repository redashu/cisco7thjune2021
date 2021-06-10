from flask import Flask 
app = Flask(__name__) 

@app.route('/') 
def hello(): 
	return "welcome to the flask With Docker and K8s hosting"



if __name__ == "__main__": 
	app.run(host ='0.0.0.0', port = 5000, debug = True) 

