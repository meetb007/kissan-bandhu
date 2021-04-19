const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const Cart = require('../models/cartModel')
const Order = require('../models/orderModel')

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
  if (!buyer || buyer.role != "buyer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  let cartItem = await Cart.find({ buyer:buyer.userFk }).exec()
  cartItem = cartItem.map((item) => item.product);
  await Cart.deleteMany({ buyer:buyer.userFk });
  const { orderId, status, payment, payment_mode, payment_done } = req.body;

  const newOrder = new Order({
    orderId,
    status,
    payment,
    payment_mode,
    payment_done,
    buyer: buyer.userFk,
    products: cartItem,
  });

  newOrder
    .save()
    .then((doc) => {
      res.status(200).json({
        message: 'Orders is added',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: 'Error in Adding Orders' + err,
        statusCode: 500,
      });
    });
});

router.get('/current', async (req, res) => {
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

  Order
    .find({buyer:buyer.userFk,status:{"$ne":"Completed"}})
    .sort({date:-1})
    .populate("products")
    .then((doc) => {
      res.status(200).json({
        message: 'Current Orders',
        length:doc.length,
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: 'Error in current Orders' + err,
        statusCode: 500,
      });
    });
});

router.get('/history', async (req, res) => {
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

  Order
    .find({buyer:buyer.userFk,status:"Completed"})
    .sort({date:-1})
    .populate("products")
    .then((doc) => {
      res.status(200).json({
        message: 'History Orders',
        length:doc.length,
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: 'Error in history Orders' + err,
        statusCode: 500,
      });
    });
});

module.exports = router;