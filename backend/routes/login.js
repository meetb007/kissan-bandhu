const express = require('express');
const Login = require('../models/loginModel');
const router = express.Router();
const md5 = require('md5');
const Token = require("../models/tokenModel");

router.post('/', async (req, res) => {
  const { mobile, password } = req.body;
  const temp = await Login.findOne({ mobile }).exec();
  if (temp && temp.password === password) {
    const token = md5(temp._id);
    const tempToken = new Token({ token, userFk: temp.userFk,role:temp.role });
    tempToken.save().then(doc =>{
      res.status(200).json({
        message: 'Login Successfully',
        statusCode: 200,
        role: temp.role,
        token
      });
    }).catch(err =>{
      res.status(401).json({
        message: 'Error in Login',
        statusCode: 401,
      });
    })
  } else {
    res.status(401).json({
      message: 'Error in Login',
      statusCode: 401,
    });
  }
});

module.exports = router;
