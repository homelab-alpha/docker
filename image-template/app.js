// Importing express module
const express = require('express')

// Creating an express application
const app = express()

// Handling GET requests to the root URL '/'
app.get('/', (req, res) => {
  res.send('Hello World!')
})

// Listening on port 3000 for incoming connections
app.listen(3000, () => {
  console.log('App listening on port 3000!')
})
