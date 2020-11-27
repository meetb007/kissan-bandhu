const express = require('express');
const Driver = require('../models/driverModel');
const router = express.Router();
const Login = require('../models/loginModel');

router.post('/', (req, res) => {
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

  const loginModel = new Login({
    mobile,
    password,
    role: 'driver',
  });

  drivertemp
    .save()
    .then((doc) => {
      loginModel.save();
    })
    .then((doc) => {
      res.status(200).json({
        message: 'Driver Register Successfully',
        response: doc,
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
