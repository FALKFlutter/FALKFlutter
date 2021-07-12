const express = require("express")
const router = express.Router()
const mongoose = require("mongoose")
const User = mongoose.model("User")
const bcrypt = require("bcryptjs")

router.get("/",(req,res)=>{
    res.send("Succes bitch")
})

router.get("/register",(req,res)=>{
    res.send("This is the register page")
})

router.post("/register",(req,res)=>{
    const {name,email,password} = req.body
    if(!name || !email || !password){
        return res.status(422).json({error: "Please fill in all fields"})
    }
    User.findOne({email:email}).then((foundUser)=>{
        if(foundUser){
            return res.status(422).json({error: "User with that email already exists"})
        }
        bcrypt.hash(password,12).then(hashedPassword=>{
            const user = new User({
                name,
                email,
                password: hashedPassword
            })
        
            user.save().then(()=>{
                res.json({message: "Succesfully created user"})
            }).catch(err=>console.log(err))
        }).catch(err=>console.log(err))
        
    }).catch(err=>console.log(err))
    

})

router.get("/login",(req,res)=>{
    res.send("This is the login page")
})

router.post("/login",(req,res)=>{
    const{email,password}= req.body
    if(!email || !password){
       return res.status(422).json({error: "Please fill in all fields"})
    }
    User.findOne({email:email}).then(foundUser=>{
        if(!foundUser){
            return res.status(422).json({error: "Invalid email or password"})
        }
        bcrypt.compare(password, foundUser.password).then(matchingPassword=>{
            if(matchingPassword){
                return res.json({message: "Succesfully logged in"})
            }else{
                return res.status(422).json({error: "Invalid email or password"})
            }
        }).catch(err=>console.log(err))
    }).catch(err=>console.log(err))
})





module.exports = router