const express = require('express');
const Buyer = require('../models/buyerModel');
const router = express.Router();
const Login = require('../models/loginModel');

router.post('/', async(req, res) => {
  const { name, password, mobile, address, latitude, longitude } = req.body;
  const buyertemp = new Buyer({
    name,
    mobile,
    address,
    latitude,
    longitude,
  });

  const temp = await Buyer.findOne({mobile}).exec();

  if(temp){
    res.status(302).json({
        message: 'Buyer Already Exist',
        response:temp,
        statusCode: 302,
    });
    return ;
  }

  buyertemp
    .save()
    .then((doc) => {
        const loginModel = new Login({
          mobile,
          password,
          role: 'buyer',
          userFk:doc._id
        });
      return loginModel.save();
    })
    .then((doc1) => {
      res.status(200).json({
        message: 'Buyer Register Successfully',
        response: doc1,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Buyer Register API', statusCode: 500 });
    });
});

module.exports = router;
