const express = require('express');
const Login = require('../models/loginModel');
const router = express.Router();

router.post('/', async (req, res) => {
  const { mobile, password } = req.body;
  const temp = await Login.findOne({ mobile }).exec();
  if (temp && temp.password === password) {
    res.status(200).json({
      message: 'Login Successfully',
      statusCode: 200,
      role: temp.role,
    });
  } else {
    res.status(401).json({
      message: 'Error in Login',
      statusCode: 401,
    });
  }
});

module.exports = router;
