from flask import Flask, request, jsonify

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
	pickUpNode = get_neighbors(farmers,driver,10)
	return pickUpNode

# calculate the Euclidean distance between two vectors
def euclidean_distance(row1, row2):
	distance = 0.0
	for i in range(len(row1)-1):
		distance += (row1[i] - row2[i])**2
	return sqrt(distance)

# Locate the most similar neighbors
def get_neighbors(farmers, driver, num_neighbors):
	distances = list()
	for farmer in farmers:
		dist = euclidean_distance(driver, farmer.coordinates)
		distances.append((farmer, dist))
	distances.sort(key=lambda tup: tup[1])
	neighbors = list()
	for i in range(num_neighbors):
		neighbors.append(distances[i][0])
	return neighbors


if __name__ == "__main__":
	app.run(debug=True)