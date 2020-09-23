const express = require('express');
const Farmer = require('../models/farmerModel');
const router = express.Router();

/**
 * @swagger
 * /auth/farmer/register:
 *  post:
 *    summary: Farmer Register
 *    description: Register Api for farmer
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
 *              name:
 *                type: string
 *              aadhar_no:
 *                type: number
 *              address:
 *                type: string
 *              latitude:
 *                type: number
 *              longitude:
 *                type: number
 *    responses:
 *      200:
 *        description: Farmer Register Successfully
 *      500:
 *        description: Error in Farmer Register API
 */
router.post('/', (req, res) => {
  const {
    name,
    password,
    mobile,
    aadhar_no,
    address,
    latitude,
    longitude,
  } = req.body;
  const farmertemp = new Farmer({
    name,
    password,
    mobile,
    aadhar_no,
    address,
    latitude,
    longitude,
  });

  farmertemp
    .save()
    .then((doc) => {
      res.status(200).json({
        message: 'Farmer Register Successfully',
        response: doc,
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
