// const express = require('express'); // Import express
import express from 'express'; // Import express    echivalentul lui const express = require('express');

const app = express(); // Create an express app

app.get('/hello/:name', (request, response) => {
  response.send('Hello, ' + request.params.name + '!!!!!!'); // Send a response to the client
});

app.listen('8080', () => {
    console.log('Listening on port 8080');
}); // Listen on port 8080
