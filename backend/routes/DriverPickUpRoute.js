const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const SellProduct = require('../models/sellProductModel');

router.get('/', async (req, res) => {
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

  SellProduct
    .find({status:"Placed"})
    .then((doc) => {
      if(doc.length === 0){
        res.status(200).json({
          message: 'No Product To Deliver',
          length:doc.length,
          response: doc,
          statusCode: 200,
        });
      }else{
        res.status(200).json({
          message: 'Place To PickUP Location',
          length:doc.length,
          response: doc,
          statusCode: 200,
        });
      }
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Driver Get API', statusCode: 500 });
    });
});


module.exports = router;