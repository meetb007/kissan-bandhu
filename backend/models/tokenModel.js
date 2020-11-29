const mongoose = require('mongoose');
const tokenSchema = mongoose.Schema({
  token: { type: String, required: true },
  userFk: { type: mongoose.Schema.Types.ObjectId },
  role:{type: String, required: true}
});

module.exports = mongoose.model('tokens', tokenSchema);
