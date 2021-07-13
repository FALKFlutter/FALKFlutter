const mongoose = require("mongoose")

const userSchema = new mongoose.Schema({
    name:{
        type: String,
        required: true
    },
    email:{
        type: String,
        required: true
    },
    password:{
        type: String,
        required: true
    },
    country:{
        type: String,
        required: true
    },
    dayOfBirth:{
        type: String,
        required: true
    }  
    
})

mongoose.model("User", userSchema)