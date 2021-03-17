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

  const buyer = await Token.findOne({ token }).exec();
  if (!buyer || buyer.role != "buyer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  const category = req.query["category"];
  // console.log(category)

  SellProduct
    .find({status:{"$ne":"Completed"},category})
    .then((doc) => {
      res.status(200).json({
        message: 'List of Product',
        length:doc.length,
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Get Product API', statusCode: 500 });
    });
});

router.get('/:id', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const buyer = await Token.findOne({ token }).exec();
  if (!buyer || buyer.role != "buyer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }


  SellProduct
    .findById(req.params.id)
    .then((doc) => {
      res.status(200).json({
        message: 'Product',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in  Get Single Product API', statusCode: 500 });
    });
});

module.exports = router;
