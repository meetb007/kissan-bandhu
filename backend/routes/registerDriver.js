const express = require('express');
const Driver = require('../models/driverModel');
const router = express.Router();
const Login = require('../models/loginModel');

router.post('/', async(req, res) => {
  const {
    name,
    password,
    mobile,
    address,
    latitude,
    longitude,
    capacity,
    driverLicence,
  } = req.body;
  const drivertemp = new Driver({
    name,
    mobile,
    address,
    latitude,
    longitude,
    capacity,
    driverLicence,
  });

  const temp = await Driver.findOne({mobile}).exec();

  if(temp){
    res.status(302).json({
        message: 'Driver Already Exist',
        response:temp,
        statusCode: 302,
    });
    return;
  }

  drivertemp
    .save()
    .then((doc) => {
      const loginModel = new Login({
        mobile,
        password,
        role: 'driver',
        userFk:doc._id
      });
      return loginModel.save();
    })
    .then((doc1) => {
      res.status(200).json({
        message: 'Driver Register Successfully',
        response: doc1,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Driver Register API', statusCode: 500 });
    });
});

module.exports = router;
