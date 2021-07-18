const mongoose = require("mongoose")
const Geocoder = require("../middleware/geocoder")

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
    dateOfBirth:{
        type: String,
        required: true
    },
    provider:{
        type: String,
        default:"Falk"
    },
    location:{
        type:{
            type: String,
            enum: ["Point"]
        },
        coordinates:{
            type:[Number],
            index:"2dsphere"
        },
        formattedAddress: String
    }
})

// userSchema.pre('save',(next)=>{
//     console.log(this.address)
//     Geocoder.geocode(this.address).then(res=>{
//         res.status(200).json({msg: "Succesfully located user"})
//     }).catch(e=>{
//         res.status(400).json({error:"Something went wrong locating user"})
//     })
// })

mongoose.model("User", userSchema)

// Use this body to for postman testing
// {
//     "name": "Kailash",
//     "email":"kailashbb12@hotmail.com",
//     "password": "Kailash",
//     "country":"Netherlands",
//     "dateOfBirth":"26 oktober 2001",
    
// }