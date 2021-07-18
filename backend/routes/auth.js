require("dotenv").config();
const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const User = mongoose.model("User");
const axios = require("axios");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const requireLogin = require("../middleware/requireLogin");
const GeoCoder = require("../middleware/geocoder");

router.get("/auth", (req, res) => {
  res.redirect(
    "https://github.com/login/oauth/authorize?client_id=" +
      process.env.GITHUB_CLIENT_ID
  );
});

router.get("/oauth-callback", (req, res) => {
  const splitName = (data) => {
    for (i = 1; i < data.length; i++) {
      if (data.charCodeAt(i) > 65 && data.charCodeAt(i) <= 90) {
        const fName = data.slice(0, i);
        const lName = data.slice(i, data.length);
        const fullName = fName + " " + lName;
        console.log(fullName);
      }
    }
  };

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
      // console.log(_res.data);
      const token = _res.data.access_token;
      // console.log("Token: ", token);
      axios
        .get("https://api.github.com/user", {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        })
        .then((resp) => {
          console.log(resp.data);
          const {
            data: { login, id, avatar_url },
            request: { host },
          } = resp;
          const userName = splitName(login);
          res.redirect("/");
        })
        .catch((e) => {
          return console.log(e);
        });
    })
    .catch((e) => {
      return res.json({ error: e });
    });
});

router.get("/", (req, res) => {
  res.send("Succes bitch");
});

router
  .route("/register")
  .get((req, res) => {
    res.send("This is the register page");
  })
  .post(async (req, res) => {
    const { name, email, password, dateOfBirth, country, provider, address } =
      req.body;
    if (!name || !email || !password || !country || !dateOfBirth || !address) {
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
      const geoLocatingAddress = await GeoCoder.geocode(address);
      console.log(geoLocatingAddress);
      const user = new User({
        name,
        email,
        password: hashedPassword,
        dateOfBirth,
        country,
        provider,
        location: {
          type: "Point",
          coordinates: [
            geoLocatingAddress[0].longitude,
            geoLocatingAddress[0].latitude,
          ],
          formattedAddress: geoLocatingAddress[0].formattedAddress,
        },
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

router
  .route("/login")
  .get((req, res) => {
    res.send("This is the login page");
  })
  .post((req, res) => {
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
              const token = jwt.sign(
                { _id: foundUser._id },
                process.env.JWT_SECRET
              );
              return res.json(token);
            } else {
              return res
                .status(422)
                .json({ error: "Invalid email or password" });
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

router.post("/test-address", async (req, res) => {
  try {
    const { lon, lat } = req.body;
    const userAddress = await GeoCoder.reverse({ lat, lon });
    res.status(200).json({msg:`Your current home address is ${userAddress[0].formattedAddress}`});
  } catch (e) {
    res.status(400).json({error:e});
  }
});

module.exports = router;
