const express = require("express")
const mongoose = require("mongoose");

const MONGOURL = process.env.MONGOURL ? process.env.MONGOURL :require('./keys').MONGOURL 

const app = express()
const PORT = process.env.PORT || 4000

require("./models/user")
mongoose.model("User")

app.use(express.json())
app.use(express.urlencoded({extended: true}))
app.use(require("./routes/auth"))

mongoose.connect(MONGOURL, {useNewUrlParser: true, useUnifiedTopology: true})

mongoose.connection.once("open",()=>{
    console.log("succesfully connected to db")
})

mongoose.connection.on("error", console.error.bind(console, "connection error:"))


app.listen(PORT, ()=>{
    console.log(`Listening on port ${PORT}`)
})