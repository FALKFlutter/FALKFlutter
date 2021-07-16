require("dotenv").config();
const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const User = mongoose.model("User");
const axios = require("axios");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const requireLogin = require("../middleware/requireLogin");


router.get("/auth", (req, res) => {
  res.redirect(
    "https://github.com/login/oauth/authorize?client_id=" +
      process.env.GITHUB_CLIENT_ID
  );
});

router.get("/oauth-callback", (req, res) => {
  const githubCode = req.query.code;
  const body = {
    client_id: process.env.GITHUB_CLIENT_ID,
    client_secret: process.env.GITHUB_SECRET,
    code: githubCode,
  };
  const opts = { headers: { accept: "application/json" } };
  axios
    .post("https://github.com/login/oauth/access_token", body, opts)
    .then((_res) => {
      console.log(_res.data.access_token);
    })
    .catch((e) => {
      return res.json({ error: e });
    });
});

router.get("/", (req, res) => {
  res.send("Succes bitch");
});

router.get("/register", (req, res) => {
  res.send("This is the register page");
});

router.post("/register", async (req, res) => {
  const { name, email, password, dateOfBirth, country } = req.body;
  if (!name || !email || !password || !country || !dateOfBirth) {
    return res.status(422).json({ error: "Please fill in all fields" });
  }
  try {
    const foundUser = await User.findOne({ email });
    if (foundUser) {
      return res
        .status(422)
        .json({ error: "User with that email already exists" });
    }
    const hashedPassword = await bcrypt.hash(password, 12);
    const user = new User({
      name,
      email,
      password: hashedPassword,
      dateOfBirth,
      country,
    });
    await user.save();
    res.json({ message: "Succesfully created user" });
  } catch (e) {
    return res.status(501).json({ error: e });
  }

  // User.findOne({ email: email })
  //   .then((foundUser) => {
  //     if (foundUser) {
  //       return res
  //         .status(422)
  //         .json({ error: "User with that email already exists" });
  //     }
  //     bcrypt
  //       .hash(password, 12)
  //       .then((hashedPassword) => {
  //         const user = new User({
  //           name,
  //           email,
  //           password: hashedPassword,
  //           dateOfBirth,
  //           country,
  //         });

  //         user
  //           .save()
  //           .then(() => {
  //             res.json({ message: "Succesfully created user" });
  //           })
  //           .catch((err) => res.json({ err }));
  //       })
  //       .catch((err) => res.json({ err }));
  //   })
  //   .catch((err) => res.json({ err }));
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
