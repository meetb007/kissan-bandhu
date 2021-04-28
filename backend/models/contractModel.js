const mongoose = require('mongoose');

const ContractSchema = mongoose.Schema({
  name: { type: String, required: true },
  description: { type: String, required: true },
  quantity: { type: String, required: true },
  date: { type: Date, default: Date.now() },
  cost: { type: String, required: true },
  soil: { type: String, required: true },
  resource: { type: String, required: true },
  contact: { type: Object, required: true },
});

module.exports = mongoose.model('contract', ContractSchema);
