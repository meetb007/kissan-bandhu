const mongoose = require('mongoose');

const buyerSchema = mongoose.Schema({
  name: { type: String, required: true },
  mobile: { type: Number, required: true },
  address: { type: String, required: true },
  latitude: { type: Number, required: true },
  longitude: { type: Number, required: true },
});

module.exports = mongoose.model('drivers', buyerSchema);
