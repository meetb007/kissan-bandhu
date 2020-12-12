const mongoose = require('mongoose');

const farmerSchema = mongoose.Schema({
	name : {type:String,required:true},
	mobile : { type: String, required: true },
	address : {type:String,required:true},
	latitude : {type:String,required:true},
	longitude : {type:String,required:true}
});

module.exports = mongoose.model('farmers', farmerSchema);
