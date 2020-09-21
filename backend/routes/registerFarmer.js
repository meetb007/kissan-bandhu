const express = require('express');
const Farmer = require('../models/farmerModel');
const router = express.Router();

router.post('/', (req, res) => {
  const { name, password, mobile, aadhar_no, address, latitude, longitude } = req.body;
  const farmertemp = new Farmer({
    name,
    password,
    mobile,
    aadhar_no,
    address,
    latitude,
    longitude
  });

  farmertemp
    .save()
    .then((doc) => {
      res.status(200).json({
        message: 'Farmer Register Successfully',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res.status(500).json({ error: 'Error in Farmer Register API', statusCode: 500 });
    });
});

module.exports = router;
