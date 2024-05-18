const express = require('express');
const socketIO = require('socket.io');
const http = require('http')
const port = process.env.PORT || 3000
var app = express();
let server = http.createServer(app);
var io = socketIO(server);

io.on('connection',(socket) => {
    console.log('New user connected');
    socket.emit('newMessage',
        {
            from: 'jen@mds',
            text: 'hepppp',
            createdAt: 123
        });

    socket.on('createMessage',
        (newMessage) => {
            console.log('newMessage', newMessage);
        });

    socket.on('disconnect',
        () => {
            console.log('disconnected from user');
        });
});

server.listen(port);