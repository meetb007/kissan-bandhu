const mongoose = require('mongoose');

const driverSchema = mongoose.Schema({
  name: { type: String, required: true },
  mobile: { type: Number, required: true },
  address: { type: String, required: true },
  latitude: { type: Number, required: true },
  longitude: { type: Number, required: true },
  capacity: { type: Number, required: true },
  driverLicence: { type: Number, required: true },
});

module.exports = mongoose.model('driver', driverSchema);
