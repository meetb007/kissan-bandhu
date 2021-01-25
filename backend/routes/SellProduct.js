const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const SellProduct = require('../models/sellProductModel');

router.post('/', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

const { name, type, quantity } = req.body;
  const sellProductTemp = new SellProduct({
    name,
    type,
    quantity,
    userFk:farmer.userFk
  });

  sellProductTemp
    .save()
    .then((doc) => {
      res.status(200).json({
        message: 'Product is Placed Successfully by Farmer',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Place Post API', statusCode: 500 });
    });

});


//get List 

router.get('/', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }


  SellProduct
    .find({userFk:farmer.userFk,status:"Placed"})
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
        .json({ error: 'Error in Farmer Place Get API', statusCode: 500 });
    });
});

//get single 

router.get('/:id', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }


  SellProduct
    .findbyid(req.params.id)
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
        .json({ error: 'Error in Farmer Place Get Single API', statusCode: 500 });
    });
});

//delete 
router.delete('/', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  const {id} = req.body;

  SellProduct
    .remove({userFk:farmer.userFk,status:"Placed",_id:id})
    .then((doc) => {
      res.status(200).json({
        message: 'Product is Deleted',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Place Delete API', statusCode: 500 });
    });
});

// get history
router.get('/history', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }


  SellProduct
    .find({userFk:farmer.userFk,status:"Completed"})
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
        .json({ error: 'Error in Farmer Place Get History API', statusCode: 500 });
    });
});

//get single history

router.get('/history/:id', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }


  SellProduct
    .findbyid(req.params.id)
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
        .json({ error: 'Error in Farmer Place Get Single History API', statusCode: 500 });
    });
});



module.exports = router;
