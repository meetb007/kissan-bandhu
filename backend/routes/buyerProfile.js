const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const Buyer = require('../models/buyerModel');


/**
 * @swagger
 * /buyer/profile:
 *  get:
 *    summary: Buyer Profile
 *    description: Api for Buyer profile
 *    tags:
 *      - name: Driver
 *    responses:
 *      200:
 *        description: Buyer Profile
 *      403:
 *        description: Error in Token
 *      500:
 *        description: Error in Buyer Profile
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

  const buyer = await Token.findOne({ token }).exec();
  if (!buyer) {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  Buyer.findById(buyer.userFk)
    .exec()
    .then((doc) => {
      res.status(200).json({
        message: 'Buyer Profile',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Buyer Profile' + err, statusCode: 500 });
    });
});


module.exports = router;
