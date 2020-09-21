const mongoose = require('mongoose');

const farmerSchema = mongoose.Schema({
	name : {type:String,required:true},
	password : { type: String, required: true },
	mobile : { type: Number, required: true },
	aadhar_no : {type:Number,required:true},
	address : {type:String,required:true},
	latitude : {type:Number,required:true},
	longitude : {type:Number,required:true}
});

module.exports = mongoose.model('farmers', farmerSchema);
