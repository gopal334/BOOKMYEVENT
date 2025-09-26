// server.js
const express = require("express");
const app = express();
const stripe = require("stripe")("sk_test_51S1uO630BnVAj8iaye7ibKTpwFBAYJbKJhYfTYf5Vo9g86WbcNP34gMLck16r3P37IEofEaijMPQEN5fFJw5eKVy00PTtD4kZF"); // 👈 apna stripe secret key yaha daalo
const cors = require("cors");

app.use(express.json());
app.use(cors());

// ✅ Create Payment Intent
app.post("/create-payment-intent", async (req, res) => {
  try {
    const { amount } = req.body; // frontend se paisa aa raha hai (in paise = INR smallest unit)

    const paymentIntent = await stripe.paymentIntents.create({
      amount: amount,
      currency: "inr",
      payment_method_types: ["card"],
    });

    res.send({
      clientSecret: paymentIntent.client_secret,
    });
  } catch (err) {
    res.status(500).send({ error: err.message });
  }
});

// ✅ Server run
app.listen(4242, () => console.log("Server running on http://localhost:4242"));
