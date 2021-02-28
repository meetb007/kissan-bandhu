const mongoose = require('mongoose');

const SellProductSchema = mongoose.Schema({
	name : {type:String,required:true},
	category : {type:String,required:true},
	description : {type:String,required:true},
	quantity : {type: String,required:true},
	userFk : { type: mongoose.Schema.Types.ObjectId,required:true},
	date : {type:Date , default: Date.now()},
	status : {type:String , default:"Placed"},
	cost :{ type: String,required:true },
	latitude : {type:String,required:true},
	longitude : {type:String,required:true},
	imageUrl : 	{ type: String,required:true }
});

module.exports = mongoose.model('sellproduct', SellProductSchema);