const express = require('express');
const Driver = require('../models/driverModel');
const router = express.Router();
const Login = require('../models/loginModel');


/**
 * @swagger
 * /auth/register/driver:
 *  post:
 *    summary: Driver Register
 *    description: Register Api for driver
 *    tags:
 *      - name: Driver
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
 *              capacity:
 *                type:number
 *              driverLicence:
 *                type:string
 *    responses:
 *      200:
 *        description: Driver Register Successfully
 *      302:
 *        description: Driver Already Exist
 *      500:
 *        description: Error in Driver Register API
 */

router.post('/', async(req, res) => {
  const {
    name,
    password,
    mobile,
    address,
    latitude,
    longitude,
  } = req.body;
  const drivertemp = new Driver({
    name,
    mobile,
    address,
    latitude,
    longitude,
  });

  const temp = await Driver.findOne({mobile}).exec();

  if(temp){
    res.status(302).json({
        message: 'Driver Already Exist',
        response:temp,
        statusCode: 302,
    });
    return;
  }

  drivertemp
    .save()
    .then((doc) => {
      const loginModel = new Login({
        mobile,
        password,
        role: 'driver',
        userFk:doc._id
      });
      return loginModel.save();
    })
    .then((doc1) => {
      res.status(200).json({
        message: 'Driver Register Successfully',
        response: doc1,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Driver Register API', statusCode: 500 });
    });
});

module.exports = router;
