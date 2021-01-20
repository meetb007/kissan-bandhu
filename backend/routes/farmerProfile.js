const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const Farmer = require('../models/farmerModel');


/**
 * @swagger
 * /farmer/profile:
 *  get:
 *    summary: Farmer Profile
 *    description: Api for farmer profile
 *    tags:
 *      - name: Farmer
 *    responses:
 *      200:
 *        description: Farmer Profile
 *      403:
 *        description: Error in Token
 *      500:
 *        description: Error in Farmer Profile
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

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer) {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  Farmer.findById(farmer.userFk)
    .exec()
    .then((doc) => {
      res.status(200).json({
        message: 'Farmer Profile',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Profile' + err, statusCode: 500 });
    });
});


module.exports = router;
