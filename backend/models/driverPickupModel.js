const mongoose = require('mongoose');
const SellProduct = require('./sellProductModel');
const Driver = require('./driverModel');

const driverPickupSchema = mongoose.Schema({
  farmers: [
    { type: mongoose.Schema.Types.ObjectId, required: true, ref: SellProduct },
  ],
  driver: { type: mongoose.Schema.Types.ObjectId, required: true, ref: Driver },
  date: { type: Date, default: Date.now() },
  status: { type: String, default: 'Completed' },
  apmc: { type: Object, required: true },
});

module.exports = mongoose.model('driverPickup', driverPickupSchema);
