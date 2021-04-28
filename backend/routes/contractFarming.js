const express = require('express');
const router = express.Router();
const Token = require('../models/tokenModel');
const Contract = require('../models/contractModel');
const Buyer = require('../models/buyerModel');

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
  if (!buyer || buyer.role != 'buyer') {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return;
  }

  const buyerDetails = await Buyer.findById(buyer.userFk).exec();

  const { name, description, quantity, cost, soil, resource } = req.body;
  let contact = { name: buyerDetails.name, mobile: buyerDetails.mobile };

  const newContract = new Contract({
    name,
    description,
    quantity,
    cost,
    soil,
    resource,
    contact,
  });

  newContract
    .save()
    .then((doc) => {
      res.status(200).json({
        message: 'Contract Placed Successfully',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: 'Error in Contract' + err,
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

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer) {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return;
  }

  Contract.find()
    .sort({ date: -1 })
    .then((doc) => {
      res.status(200).json({
        message: 'List of Contract',
        length: doc.length,
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: 'Error in Get Contract' + err,
        statusCode: 500,
      });
    });
});

module.exports = router;
