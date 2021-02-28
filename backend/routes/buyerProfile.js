const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const Buyer = require('../models/buyerModel');
const multer = require('multer');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/profileimage');
  },
  filename: function (req, file, cb) {
    cb(null, new Date().toISOString() + file.originalname);
  },
});

const fileFilter = (req, file, cb) => {
  if (
    file.mimetype === 'image/jpeg' ||
    file.mimetype === 'image/jpg' ||
    file.mimetype === 'image/png'
  ) {
    cb(null, true);
  } else {
    cb(new Error('File Name is not Supported'), false);
  }
};
const upload = multer({ storage: storage, fileFilter: fileFilter });

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

router.post('/upload', upload.single("image"), async (req, res) => {
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

  var imageUrl = req.file.filename;
  Buyer.findOneAndUpdate({token},{imageUrl})
    .then((doc) => {
      res.status(200).json({
        message: 'Successfully uploaded Profile Image',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Buyer Profile Image', statusCode: 500 });
    });

});


module.exports = router;
