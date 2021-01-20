const express = require('express');
const app = express();
const bodyparser = require('body-parser');
const mongoose = require('mongoose');
const config = require('./config');
const swaggerUi = require('swagger-ui-express');
const swaggerJsdoc = require('swagger-jsdoc');

const db = config.url;
const port = process.env.PORT || 5000;

const LoginRoute = require('./routes/login');
const farmerRegisterRoute = require('./routes/registerFarmer');
const driverRegisterRoute = require('./routes/registerDriver');
const buyerRegisterRoute = require('./routes/registerBuyer');
const farmerProfileRoute = require('./routes/farmerProfile');

mongoose.connect(
  db,
  { useNewUrlParser: true, useUnifiedTopology: true },
  (err, res) => {
    if (err) {
      console.log('Error', err);
    } else {
      console.log('Contected to database');
    }
  }
);

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Kisaan Bandhu',
      description: 'An Api Documentation for Kisaan Bandhu',
      version: '1.0.0',
    },
  },
  apis: ['./routes/*.js'],
};

const swaggerSpec = swaggerJsdoc(options);

app.use(bodyparser.urlencoded({ extended: false }));
app.use(bodyparser.json());

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', '*');
  if (req.method === 'OPTIONS') {
    res.header('Access-Control-Allow-Methods', 'GET POST PATCH DELETE');
    return res.status(200).json({});
  }
  next();
});

app.get("/",(req,res)=>{
  res.send("API for kissan bandhu");
})
app.use('/auth/login', LoginRoute);
app.use('/auth/register/farmer', farmerRegisterRoute);
app.use('/auth/register/driver', driverRegisterRoute);
app.use('/auth/register/buyer', buyerRegisterRoute);
app.use('/farmer/profile',farmerProfileRoute);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

app.use((req, res, next) => {
  const err = new Error('Not Found');
  err.status = 404;
  next(err);
});

app.use((err, req, res, next) => {
  res.status(err.status || 500);
  res.json({
    Error: err.message,
  });
});

app.listen(port, () => console.log(`Listen at port ${port}`));
