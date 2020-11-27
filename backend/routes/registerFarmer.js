const express = require('express');
const Farmer = require('../models/farmerModel');
const router = express.Router();
const Login = require('../models/loginModel');

router.post('/', (req, res) => {
  const { name, password, mobile, address, latitude, longitude } = req.body;
  const farmertemp = new Farmer({
    name,
    mobile,
    address,
    latitude,
    longitude,
  });

  const loginModel = new Login({
    mobile,
    password,
    role: 'farmer',
  });

  farmertemp
    .save()
    .then((doc) => {
      loginModel.save();
    })
    .then((doc) => {
      res.status(200).json({
        message: 'Farmer Register Successfully',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Register API', statusCode: 500 });
    });
});

module.exports = router;
