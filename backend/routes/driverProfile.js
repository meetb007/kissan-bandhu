const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const Driver = require('../models/driverModel');


/**
 * @swagger
 * /driver/profile:
 *  get:
 *    summary: Driver Profile
 *    description: Api for Driver profile
 *    tags:
 *      - name: Driver
 *    responses:
 *      200:
 *        description: Driver Profile
 *      403:
 *        description: Error in Token
 *      500:
 *        description: Error in Driver Profile
 */
router.get('/', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const driver = await Token.findOne({ token }).exec();
  if (!driver) {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  Driver.findById(driver.userFk)
    .exec()
    .then((doc) => {
      res.status(200).json({
        message: 'Driver Profile',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Driver Profile' + err, statusCode: 500 });
    });
});


module.exports = router;
