const mongoose = require('mongoose');
const Product = require('./sellProductModel');
const Buyer = require('./buyerModel');

const ordersSchema = mongoose.Schema({
  date: { type: Date, default: new Date() },
  orderId: { type: String, required: true },
  status: { type: String },
  payment: { type: String, required: true },
  products: [{ type: mongoose.Schema.Types.ObjectId, ref: Product, required: true }],
  buyer: { type: mongoose.Schema.Types.ObjectId, ref: Buyer, required: true },
  payment_mode: { type: String, required: true },
  payment_done: { type: String, required: true },
});

module.exports = mongoose.model('orders', ordersSchema);
