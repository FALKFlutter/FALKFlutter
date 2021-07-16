require("dotenv").config();
const jwt = require("jsonwebtoken");
const mongoose = require("mongoose");
const User = mongoose.model("User");

module.exports = (req, res, next) => {
  const { authorization } = req.headers;
  if (!authorization) {
    return res
      .status(422)
      .json({ error: "You must be logged in to view this page" });
  }
  const authToken = authorization.split(" ")[1];
  jwt.verify(authToken, process.env.JWT_SECRET, (err, payload) => {
    if (err) return res.json({ error: "Unverified user" });

    const { _id } = payload;
    User.findById({ _id })
      .then((userData) => {
        req.user = userData;
        next();
      })
      .catch((err) => res.status(422).json({ error: "Something went wrong" }));
  });
};
