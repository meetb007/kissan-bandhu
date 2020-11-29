const mongoose = require('mongoose');

const LoginSchema = mongoose.Schema({
	password : {type:String,required:true},
	mobile : { type: String, required: true },
	role : {type:String,required:true},
	userFk: { type: mongoose.Schema.Types.ObjectId},
});

module.exports = mongoose.model('login', LoginSchema);