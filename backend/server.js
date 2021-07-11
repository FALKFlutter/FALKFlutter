const express = require("express")
const mongoose = require("mongoose")
const{MONGOURL} = require("./keys")

const app = express()
const PORT = 3000

mongoose.connect(MONGOURL, {useNewUrlParser: true, useUnifiedTopology: true})

mongoose.connection.once("open",()=>{
    console.log("succesfully connected to db")
})

mongoose.connection.on("error", console.error.bind(console, "connection error:"))


app.get("/",(req,res)=>{
    res.send("hi")
})

app.listen(PORT, ()=>{
    console.log(`Listening on port ${PORT}`)
})