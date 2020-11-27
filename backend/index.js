const express = require('express');
const app = express();
const bodyparser = require('body-parser');
const mongoose = require('mongoose');
const db = 'mongodb://localhost/kisaan';
const port = 5000;

const LoginRoute = require('./routes/login');
const farmerRegisterRoute = require('./routes/registerFarmer');
const driverRegisterRoute = require('./routes/registerDriver');
const buyerRegisterRoute = require('./routes/registerBuyer');

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

app.use('/auth/login', LoginRoute);
app.use('/auth/register/farmer', farmerRegisterRoute);
app.use('/auth/register/driver', driverRegisterRoute);
app.use('/auth/register/buyer', buyerRegisterRoute);

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
