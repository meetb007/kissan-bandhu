const express = require('express');
const router = express.Router();
const Token = require('../models/tokenModel');
const DriverHistory = require('../models/driverPickupModel');
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

  const driver = await Token.findOne({ token }).exec();
  if (!driver) {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return;
  }
  const { pickupLocation } = req.body;
  var farmers = [];
  for (i = 1; i < pickupLocation.length - 1; i++) {
    farmers.push(pickupLocation[i]['_id']);
  }
  let apmcIndex = pickupLocation.length - 1;
  let apmc = pickupLocation[apmcIndex];

  const newdriverHistory = new DriverHistory({
    farmers,
    apmc,
    driver: driver.userFk,
  });
  newdriverHistory
    .save()
    .then((doc) => {
      SellProduct.updateMany(
        { _id: { $in: farmers } },
        { $set: { status: 'Transport' } }
      ).then((doc1) => {
        res.status(200).json({
          message: 'Transportation is done Successfully',
          response: doc1,
          statusCode: 200,
        });
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: 'Error in Post Request in Driver History',
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

  const driver = await Token.findOne({ token }).exec();
  if (!driver) {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return;
  }

  DriverHistory.find({ driver: driver.userFk })
    .populate('farmers')
    .sort({ date: -1 })
    .exec()
    .then((doc) => {
      res.status(200).json({
        message: 'Driver History',
        length: doc.length,
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: 'Error in get driver history',
        statusCode: 500,
      });
    });
});

module.exports = router;
