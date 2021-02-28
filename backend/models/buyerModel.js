const mongoose = require('mongoose');

const buyerSchema = mongoose.Schema({
  name: { type: String, required: true },
  mobile: { type: String, required: true },
  address: { type: String, required: true },
  latitude: { type: String, required: true },
  longitude: { type: String, required: true },
  imageUrl : { type: String}
});

module.exports = mongoose.model('buyers', buyerSchema);
