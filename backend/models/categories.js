const mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema.Types;

const categoriesSchema = new mongoose.Schema({
  userCategories: {
    zodiac: {
      type: String,
      required: true,
    },
    food: {
      type: String,
      required: true,
    },
    movies: {
      type: String,
      required: true,
    },
    dates: {
      type: String,
      required: true,
    },
    topics: {
      type: String,
      required: true,
    },
    danceStyles: {
      type: String,
      required: true,
    },
    music: {
      type: String,
      required: true,
    }
  },
  categoriesPreferedByUser: {
    zodiacPref: {
      type: String,
      required: true,
    },
    foodPref: {
      type: String,
      required: true,
    },
    moviesPref: {
      type: String,
      required: true,
    },
    datesPref: {
      type: String,
      required: true,
    },
    topicsPref: {
      type: String,
      required: true,
    },
    danceStylesPref: {
      type: String,
      required: true,
    },
    musicPref: {
      type: String,
      required: true,
    }
  },belongedUser:{
      ref: "User",
      type: ObjectId
  }
});

mongoose.model("Categories", categoriesSchema)
