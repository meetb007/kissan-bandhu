const mongoose = require('mongoose');

const CategorySchema = mongoose.Schema({
	name : {type:String,required:true},
	type : {type:String,required:true}
});

module.exports = mongoose.model('category', CategorySchema);
