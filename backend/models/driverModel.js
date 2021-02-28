const mongoose = require('mongoose');

const driverSchema = mongoose.Schema({
  name: { type: String, required: true },
  mobile: { type: String, required: true },
  address: { type: String, required: true },
  latitude: { type: String, required: true },
  longitude: { type: String, required: true },
  capacity: { type: String },
  driverLicence: { type: String},
  imageUrl : { type: String }
});

module.exports = mongoose.model('driver', driverSchema);
