const express = require('express');
const Farmer = require('../models/farmerModel');
const router = express.Router();
const Login = require('../models/loginModel');

router.post('/', async(req, res) => {
  const { name, password, mobile, address, latitude, longitude } = req.body;
  const farmertemp = new Farmer({
    name,
    mobile,
    address,
    latitude,
    longitude,
  });

  const temp = await Farmer.findOne({mobile}).exec();

  if(temp){
    res.status(302).json({
        message: 'Farmer Already Exist',
        response:temp,
        statusCode: 302,
    });
    return
  }

  farmertemp
    .save()
    .then((doc) => {
      const loginModel = new Login({
        mobile,
        password,
        role: 'farmer',
        userFk:doc._id
      });
      return loginModel.save();
    })
    .then((doc1) => {
      res.status(200).json({
        message: 'Farmer Register Successfully',
        response: doc1,
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
