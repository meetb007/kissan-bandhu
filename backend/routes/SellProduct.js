const express = require('express')
const router = express.Router();
const Token = require('../models/tokenModel');
const SellProduct = require('../models/sellProductModel');
const multer = require('multer');
const path = require('path')
const { Storage } = require('@google-cloud/storage');

// const storage = multer.diskStorage({
//   destination: function (req, file, cb) {
//     cb(null, 'uploads/');
//   },
//   filename: function (req, file, cb) {
//     cb(null, new Date().toISOString() + file.originalname);
//   },
// });

const storage = new Storage({
  projectId: "kisaan-acdda",
  keyFilename: path.join(__dirname,'../key.json'),
});

const bucket = storage.bucket('gs://kisaan-acdda.appspot.com');

// Initiating a memory storage engine to store files as Buffer objects
const uploader = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 10 * 1024 * 1024, // limiting files size to 5 MB
  },
});

// const fileFilter = (req, file, cb) => {
//   console.log(file.mimetype)
//   if (
//     file.mimetype === 'image/jpeg' ||
//     file.mimetype === 'image/jpg' ||
//     file.mimetype === 'image/png'
//   ) {
//     cb(null, true);
//   } else {
//     cb(new Error('File Name is not Supported'), false);
//   }
// };
// const upload = multer({ storage: storage});

router.post('/',uploader.single('image'),async (req, res) => {
  console.log(req.body);
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

  try{

    if (!req.file) {
      res.status(400).json({error:"Error Occur While Upload"});
      return;
    }

    // Create new blob in the bucket referencing the file
    const blob = bucket.file(req.file.originalname);

    // Create writable stream and specifying file mimetype
    const blobWriter = blob.createWriteStream({
      metadata: {
        contentType: req.file.mimetype,
      },
    });

    blobWriter.on('error', (err) =>{
      res
        .status(500)
        .json({ error: 'Error in Blob Writer', statusCode: 500 });
      return;
    });

    blobWriter.on('finish',()=>{
      const publicUrl = `https://firebasestorage.googleapis.com/v0/b/${bucket.name}/o/${encodeURI(blob.name)}?alt=media`;

      const { name, quantity,cost,latitude, longitude,category,description} = req.body;
      // console.log(req.body)
      const sellProductTemp = new SellProduct({
        name,
        quantity,
        userFk:farmer.userFk,
        cost,
        latitude,
        longitude,
        imageUrl:publicUrl,
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
    })
    // var imageUrl = req.file.filename;
      blobWriter.end(req.file.buffer);
    }
    catch (error) {
    res.status(400).json({ error: 'Error', statusCode: 500 });
    return;
  }
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
    .sort({date:-1})
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
//Edit
router.put('/:id', async (req, res) => {
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

  const id = req.params.id;
  const {name, quantity,cost,description} = req.body;

  SellProduct
    .updateOne({"status":"Placed",_id:id},{name,quantity,cost,description})
    .exec()
    .then((doc) => {
      res.status(200).json({
        message: 'Product is Updated',
        response: doc,
        statusCode: 200,
      });
    })
    .catch((err) => {
      res
        .status(500)
        .json({ error: 'Error in Farmer Place Put API', statusCode: 500 });
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
    .sort({date:-1})
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
