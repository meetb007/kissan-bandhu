const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const SellProduct = require('../models/sellProductModel');
const Driver = require('../models/driverModel')
const axios = require('axios');

router.post('/', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const driver = await Token.findOne({ token }).exec();
  if (!driver || driver.role != "driver") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  var docs = await SellProduct.find({status:"Placed"})
  if(docs.length==0){
    res.status(200).json({
      message: 'No Product To Deliver',
      length:doc.length,
      response: doc,
      statusCode: 200,
    });
    return ;
  }
  var tempDriver = await Driver.findById(driver.userFk).exec();
  if(!tempDriver.capacity){
    res.status(200).json({
      message: 'Capacity is Required',
      statusCode: 200,
    });
    return;
  }
  const {latitude,longitude} = req.body;

  axios.post('https://kissan-bandhu.govindapatel61.repl.co/clustering',
    {farmers:docs,
     driver:{capacity:tempDriver.capacity,coordinates:[latitude,longitude]}
   })
  .then(result =>{
    console.log(result)
    res.status(200).json({
      message: 'Place To PickUP Location',
      length:result.data.length,
      response: result.data,
      statusCode: 200,
    });
  })
  .catch((err) => {
    res
      .status(500)
      .json({ error: 'Error in Driver Post API', statusCode: 500 });
    });
});


module.exports = router;