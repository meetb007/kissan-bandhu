const express = require('express');
const app = express();
const bodyparser = require('body-parser');
const mongoose = require('mongoose');
const swaggerUi = require('swagger-ui-express');
const swaggerJsdoc = require('swagger-jsdoc');
const db = 'mongodb://localhost/kisaan';
const port = 5000;

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

const farmerLoginRoute = require('./routes/loginFarmer');
const farmerRegisterRoute = require('./routes/registerFarmer');

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

app.use(bodyparser.urlencoded({ extended: false }));
app.use(bodyparser.json());

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));
app.use('/auth/farmer/login', farmerLoginRoute);
app.use('/auth/farmer/register', farmerRegisterRoute);

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
