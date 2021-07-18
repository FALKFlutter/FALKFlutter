require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");

const MONGOURL = process.env.MONGOURL;

const app = express();
const PORT = process.env.PORT || 4000;

require("./models/user");
require("./models/categories")
mongoose.model("User")
mongoose.model("Categories");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(require("./routes/auth"));
app.use(require("./routes/categories"));

mongoose.connect(MONGOURL, { useNewUrlParser: true, useUnifiedTopology: true });

mongoose.connection.once("open", () => {
  console.log("succesfully connected to db");
});

mongoose.connection.on(
  "error",
  console.error.bind(console, "connection error:")
);

app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});
