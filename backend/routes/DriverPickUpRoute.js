const express = require('express');
const router = express.Router();
const Token = require('../models/tokenModel');
const SellProduct = require('../models/sellProductModel');
const Driver = require('../models/driverModel');
const DriverHistory = require('../models/driverPickupModel');
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
  if (!driver || driver.role != 'driver') {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return;
  }

  var docs = await SellProduct.find({ status: 'Placed' });
  if (docs.length == 0) {
    res.status(200).json({
      message: 'No Product To Deliver',
      length: doc.length,
      response: doc,
      statusCode: 200,
    });
    return;
  }
  var tempDriver = await Driver.findById(driver.userFk).exec();
  if (!tempDriver.capacity) {
    res.status(200).json({
      message: 'Capacity is Required',
      statusCode: 200,
    });
    return;
  }
  const { latitude, longitude } = req.body;

  axios
    .post('https://kissan-bandhu.govindapatel61.repl.co/clustering', {
      farmers: docs,
      driver: { capacity: tempDriver.capacity, latitude, longitude },
    })
    .then((result) => {
      // console.log(result)
      var location = result.data.data;
      var pickupFarmer = [];
      for (let i = 1; i < location.length - 1; i++) {
        pickupFarmer.push(location[i]['_id']);
      }
      console.log(pickupFarmer);
      if (location.length > 2) {
        SellProduct.updateMany(
          { _id: { $in: pickupFarmer } },
          { $set: { status: 'Pickup' } }
        ).then((docsTemp) => {
          const newdriverHistory = new DriverHistory({
            farmers: pickupFarmer,
            apmc: location[location.length - 1],
            status: 'Placed',
            driver: driver.userFk,
          });
          newdriverHistory.save().then((driverResponse) => {
            res.status(200).json({
              message: 'Place To PickUP Location',
              length: result.data.data.length,
              response: result.data.data,
              id: driverResponse._id,
              statusCode: 200,
            });
          });
        });
      } else {
        res.status(200).json({
          message: 'Place To PickUP Location',
          length: result.data.data.length,
          response: result.data.data,
          statusCode: 200,
        });
      }
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Driver Post API', statusCode: 500 });
    });
});

module.exports = router;
