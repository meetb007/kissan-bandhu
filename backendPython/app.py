from flask import Flask, request, jsonify
from math import radians, cos, sin, asin, sqrt 

app = Flask(__name__)

@app.route('/')
def index():
	return 'Flask API For Kissan Bandhu'

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
	app.run(debug=True)