const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const SellProduct = require('../models/sellProductModel');
const multer = require('multer');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    cb(null, new Date().toISOString() + file.originalname);
  },
});

const fileFilter = (req, file, cb) => {
  console.log(file.mimetype)
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
const upload = multer({ storage: storage});

router.post('/', upload.single("image"), async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }


  var imageUrl = req.file.filename;
  const { name, quantity,cost,latitude, longitude,category,description } = req.body;
  console.log(req.body)
  const sellProductTemp = new SellProduct({
    name,
    quantity,
    userFk:farmer.userFk,
    cost,
    latitude,
    longitude,
    imageUrl,
    category,
    description
  });

  sellProductTemp
    .save()
    .then((doc) => {
      res.status(200).json({
        message: 'Product is Placed Successfully by Farmer',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Place Post API', statusCode: 500 });
    });

});


//get List 

router.get('/current', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }


  SellProduct
    .find({userFk:farmer.userFk,status:{"$ne":"Completed"}})
    .then((doc) => {
      res.status(200).json({
        message: 'List of Product',
        length:doc.length,
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Place Get API', statusCode: 500 });
    });
});

//get single 

router.get('/current/:id', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }


  SellProduct
    .findById(req.params.id)
    .then((doc) => {
      res.status(200).json({
        message: 'Product',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Place Get Single API', statusCode: 500 });
    });
});

//delete 
router.delete('/', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }

  const {id} = req.body;

  SellProduct
    .remove({userFk:farmer.userFk,status:"Placed",_id:id})
    .then((doc) => {
      res.status(200).json({
        message: 'Product is Deleted',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Place Delete API', statusCode: 500 });
    });
});

// get history
router.get('/history', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }


  SellProduct
    .find({userFk:farmer.userFk,status:"Completed"})
    .then((doc) => {
      res.status(200).json({
        message: 'List of Product',
        length:doc.length,
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Place Get History API', statusCode: 500 });
    });
});

//get single history

router.get('/history/:id', async (req, res) => {
  const token = req.headers.authorization;
  if (!token) {
    res.status(403).json({
      message: 'Token is Required',
      statusCode: 403,
    });
    return;
  }

  const farmer = await Token.findOne({ token }).exec();
  if (!farmer || farmer.role != "farmer") {
    res.status(403).json({
      message: 'Token is Invalid',
      statusCode: 403,
    });
    return ;
  }


  SellProduct
    .findById(req.params.id)
    .then((doc) => {
      res.status(200).json({
        message: 'Product',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Place Get Single History API', statusCode: 500 });
    });
});



module.exports = router;
