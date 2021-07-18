const express = require("express")
const router = express.Router()
const mongoose = require("mongoose")
const requireLogin = require("../middleware/requireLogin")

// Use the user's location to find their matches
// The users will have to specify the range which they want their matches to be in

module.exports = router