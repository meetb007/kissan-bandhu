const mongoose = require('mongoose');

const SellProductSchema = mongoose.Schema({
	name : {type:String,required:true},
	type : { type: mongoose.Schema.Types.ObjectId,required:true},
	quantity : {type: Number,required:true},
	userFk : { type: mongoose.Schema.Types.ObjectId,required:true},
	date : {type:Date , default: Date.now()},
	status : {type:String , default:"Placed"}	
});

module.exports = mongoose.model('sellproduct', SellProductSchema);