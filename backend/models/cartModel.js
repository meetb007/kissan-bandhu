const mongoose = require('mongoose');
const Product = require('./sellProductModel');
const Buyer = require('./buyerModel');

const cartSchema = mongoose.Schema({
  product: { type: mongoose.Schema.Types.ObjectId, required: true, ref: Product},
  buyer: { type: mongoose.Schema.Types.ObjectId, required: true, ref: Buyer },
  quantity: { type: String, default: "1"},
});

module.exports = mongoose.model('carts', cartSchema);
