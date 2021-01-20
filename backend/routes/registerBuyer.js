const express = require('express');
const Buyer = require('../models/buyerModel');
const router = express.Router();
const Login = require('../models/loginModel');

/**
 * @swagger
 * /auth/register/buyer:
 *  post:
 *    summary: Buyer Register
 *    description: Register Api for buyer
 *    tags:
 *      - name: Buyer
 *    requestBody:
 *      content:
 *        application/json:
 *          schema:
 *            properties:
 *              mobile:
 *                type: number
 *              password:
 *                type: string
 *              name:
 *                type: string
 *              address:
 *                type: string
 *              latitude:
 *                type: number
 *              longitude:
 *                type: number
 *    responses:
 *      200:
 *        description: Buyer Register Successfully
 *      302:
 *        description: Buyer Already Exist
 *      500:
 *        description: Error in Buyer Register API
 */

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
