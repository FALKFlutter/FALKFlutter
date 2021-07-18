const express = require("express");
const router = express.Router();
const mongoose = require("mongoose")
const userCategoriesSchema = mongoose.model("Categories");
const requireLogin = require("../middleware/requireLogin")

router.get("/categories",requireLogin, (req, res) => {
  res.send(`Hello ${req.user.name}, welcome to the categories page.`);
});

router.post("/categories", requireLogin,(req, res) => {
  const { zodiac, food, movies, dates, topics, danceStyles, music } =
    req.body.userChoices;
  const {
    zodiacPref,
    foodPref,
    moviesPref,
    datesPref,
    topicsPref,
    danceStylesPref,
    musicPref,
  } = req.body.userPref
  const {name, _id} = req.user

  const newUserCategories = new userCategoriesSchema({
    userCategories: {
      zodiac,
      food,
      movies,
      dates,
      topics,
      danceStyles,
      music
    },
    categoriesPreferedByUser:{
        zodiacPref,
        foodPref,
        moviesPref,
        datesPref,
        topicsPref,
        danceStylesPref,
        musicPref   
    },
    belongedUser: req.user
  })
  
  newUserCategories.save().then(resp=>{
      res.status(200).json({msg: "succesfully created profile"})
  }).catch(e=>{res.status(400).json({error: e})});
});

module.exports = router;
