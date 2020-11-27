const mongoose = require('mongoose');

const LoginSchema = mongoose.Schema({
	password : {type:String,required:true},
	mobile : { type: Number, required: true },
	role : {type:String,required:true}
});

module.exports = mongoose.model('login', LoginSchema);