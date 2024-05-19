const express = require('express');
const app = express();
const cors = require('cors');
app.use(cors())
const http = require('http');
const server = http.createServer(app);
const port = 9090;
const { Server } = require('socket.io');
const io = new Server(server,
    {
        cors: {
            origin: "*",
            methods: ["GET", "POST"]
        }
    }
);
app.get('/', (req, res) => {
    res.send('Hello World');
});
const dearMessages = [];
const chatMessages = [];

io.on('connection', (socket) => {
    console.log('Connected user : ' + socket.id);
    console.log("Recovered: " + socket.recovered);

    socket.on('chat message', (message) => {
        console.log('Chat Message: ' + message);
        chatMessages.push(message + "-- recieved by server");
        io.emit('chat message', chatMessages);
    });

    socket.on('dear message', (message) => {
        console.log('Dear Message: ' + message);
        dearMessages.push(message);
        io.emit('dear message', dearMessages);
    });

    socket.on('disconnect', () => {
        console.log('A user disconnected');
    });
});
server.listen(port, () => {
    console.log('Server started');
})