const express = require('express');
const Farmer = require('../models/farmerModel');
const router = express.Router();

/**
 * @swagger
 * /auth/farmer/login:
 *  post:
 *    summary: Farmer Logins
 *    description: Login Api for farmer
 *    tags:
 *      - name: Farmer
 *    requestBody:
 *      content:
 *        application/json:
 *          schema:
 *            properties:
 *              mobile:
 *                type: number
 *              password:
 *                type: string
 *
 *    responses:
 *      200:
 *        description: Login Successfully
 *      401:
 *        description: Error in Login
 */
router.post('/', async (req, res) => {
  const { mobile, password } = req.body;
  const temp = await Farmer.findOne({ mobile }).exec();
  if (temp && temp.password === password) {
    res.status(200).json({
      message: 'Login Successfully',
      statusCode: 200,
    });
  } else {
    res.status(401).json({
      message: 'Error in Login',
      statusCode: 401,
    });
  }
});

module.exports = router;
