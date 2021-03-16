const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const Cart = require('../models/cartModel');

router.post('/', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const buyer = await Token.findOne({ token }).exec();
  if (!buyer) {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }
  const { product,quantity } = req.body;
  const newCart = new Cart({
    product,
    buyer: buyer.userFk,
    quantity
  });
  newCart
    .save()
    .then((doc) => {
      res.status(200).json({
        message: 'Product Added Successfully in Cart',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: 'Error in Adding Product in Cart',
        statusCode: 500,
      });
    });
});

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
  if (!buyer) {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  Cart.find({ buyer: buyer.userFk })
    .populate('product')
    .exec()
    .then((doc) => {
      res.status(200).json({
        message: 'List of Product in Cart',
        length:doc.length,
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({ 
      	error: 'Error in Cart while Getting Cart details', 
      	statusCode: 500 
      });
    });
});

router.delete('/:id', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const buyer = await Token.findOne({ token }).exec();
  if (!buyer) {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  const id = req.params.id;

  Cart.deleteOne({ _id: id })
    .exec()
    .then((doc) => {
      res.status(200).json({
        message: 'Item is Deleted from Cart',
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({ 
      	error: 'Error in Delete Cart', 
      	statusCode: 500 
      });
    });
});

router.put('/:id', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const buyer = await Token.findOne({ token }).exec();
  if (!buyer) {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  const id = req.params.id;
  const { quantity } = req.body;

  Cart.updateOne({ _id: id }, { quantity })
    .exec()
    .then((doc) => {
      res.status(200).json({
        message: 'Item is Updated in Cart',
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({ 
      	error: 'Error in Update Cart', 
      	statusCode: 500 
      });
    });
});

module.exports = router;