from flask import Flask, request, jsonify
from math import radians, cos, sin, asin, sqrt
import os 
import numpy as np
from cv2 import cv2
import json
from keras.models import model_from_json
import tensorflow.keras.optimizers as Optimizer
from threading import Thread
from werkzeug.utils import secure_filename

uploadFolder = 'upload/'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = uploadFolder

dictName = ['Rice','Tomato','Potato','LadyFinger','Strawberry']

@app.route('/')
def index():
	print("Call")
	print(predictType("0.jpg"))
	return jsonify(message='Hello From API',statusCode = 200)

@app.route('/clustering',methods=["POST"])
def knn():
	data = request.json
	print(data)
	data = jsonify(data)
	farmers = data.farmers
	driver = data.driver
	#Threshold to 100 KM
	threshold = 100
	num_neighbors = 10
	pickUpNodes = get_neighbors(farmers,driver,num_neighbors,threshold)
	pickUpLocation = findPathForDriver(pickUpNodes)
	return pickUpLocation

@app.route('/predictItem',methods=["GET"])
def predict():
	if 'file' not in request.files:
		return jsonify(message='Image is Required',statusCode = 304)
	file = request.files['file']
	if file.filename == '':
		return jsonify(message='Select Proper Image',statusCode = 304)
	if file and allowedFile(file.filename):
		filename = secure_filename(file.filename)
		file.save(os.path.join(app.config(['UPLOAD_FOLDER'],filename)))
		return jsonify(data=predictType(filename),statusCode = 200)
	

def allowedFile(filename):
	return "." in filename and filename.rsplit('.',1)[1].lower() in ALLOWED_EXTENSIONS

def predictType(filename):
	print("Hello")
	jsonFile = open('demo.json','r')
	loadedModelJson = jsonFile.read()
	print("Hello12")
	jsonFile.close()
	loadedModel = model_from_json(loadedModelJson,custom_objects=None)
	loadedModel.load_weights("model.h5")
	loadedModel.compile(optimizer=Optimizer.Adam(lr=0.0001),loss='sparse_categorical_crossentropy',metrics=['accuracy'])
	print('Hello3')
	print('upload/' + filename)
	img = cv2.imread("upload/" + filename)
	img = cv2.resize(img,(150,150))
	predictArray = loadedModel.predict(np.array([img]))[0]
	index = np.where(predictArray == max(predictArray))[0][0]
	return dictName[index]


# calculate the distance between two vectors
def distanceBtwTwoLocation(driver,farmer):
	lat1 = radians(driver[0])
	lon1 = radians(driver[1])
	lat2 = radians(farmer[0])
	lon2 = radians(farmer[1])

	#Haversine Formula
	dlon = lon2 - lon1  
	dlat = lat2 - lat1

	a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
	c = 2 * asin(sqrt(a))
	r = 6371
	return (c * r)


# Locate the most similar neighbors
def get_neighbors(farmers, driver, num_neighbors,threshold):
	distances = list()
	for farmer in farmers:
		dist = distanceBtwTwoLocation(driver, farmer.coordinates)
		if dist < threshold:
			distances.append((farmer, dist))

	distances.sort(key=lambda tup: tup[1])
	neighbors = list()
	for i in range(num_neighbors):
		if i < len(distances):
			neighbors.append(distances[i][0])
	return neighbors


#Use Alogrithm to Find smallest path
def findPathForDriver(pickUpNodes):
	pass




if __name__ == "__main__":
	app.run()