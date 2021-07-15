const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const User = mongoose.model("User");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const JWT_SECRET = process.env.JWT
  ? process.env.JWT
  : require("./keys").JWT_SECRET;
const requireLogin = require("../middleware/requireLogin");

router.get("/", (req, res) => {
  res.send("Succes bitch");
});

router.get("/register", (req, res) => {
  res.send("This is the register page");
});

router.post("/register", (req, res) => {
  const { name, email, password, dateOfBirth, country } = req.body;
  if (!name || !email || !password || !country || !dateOfBirth) {
    return res.status(422).json({ error: "Please fill in all fields" });
  }
  User.findOne({ email: email })
    .then((foundUser) => {
      if (foundUser) {
        return res
          .status(422)
          .json({ error: "User with that email already exists" });
      }
      bcrypt
        .hash(password, 12)
        .then((hashedPassword) => {
          const user = new User({
            name,
            email,
            password: hashedPassword,
            dayOfBirth,
            country,
          });

          user
            .save()
            .then(() => {
              res.json({ message: "Succesfully created user" });
            })
            .catch((err) => res.json({ err }));
        })
        .catch((err) => res.json({ err }));
    })
    .catch((err) => res.json({ err }));
});

router.get("/login", (req, res) => {
  res.send("This is the login page");
});

router.post("/login", (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(422).json({ error: "Please fill in all fields" });
  }
  User.findOne({ email: email })
    .then((foundUser) => {
      if (!foundUser) {
        return res.status(422).json({ error: "Invalid email or password" });
      }
      bcrypt
        .compare(password, foundUser.password)
        .then((matchingPassword) => {
          if (matchingPassword) {
            const token = jwt.sign({ _id: foundUser._id }, JWT_SECRET);
            return res.json(token);
          } else {
            return res.status(422).json({ error: "Invalid email or password" });
          }
        })
        .catch((err) => res.json(err));
    })
    .catch((err) => res.json(err));
});

router.get("/protected", requireLogin, (req, res) => {
  const { name } = req.user;
  res.send(`Hello ${name}`);
});

module.exports = router;
