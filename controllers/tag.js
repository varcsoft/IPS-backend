import crud from "../utils/crud.js"
import crudf from "../utils/crudf.js";
import { sendresponse } from "../utils/utils.js";
import bcrypt from "bcrypt";
import checkAuth from "../middlewares/checkAuth.js";
import constants from "../utils/constants.js";
const salt = bcrypt.genSaltSync(10);
import http from 'http';
import { Server } from 'socket.io';
let io;
const initsocket = async (app) => {
    const server = http.createServer(app);
    const port = 9090;
    io = new Server(server,
        {
            cors: {
                origin: "*",
                methods: ["GET", "POST"]
            }
        }
    );
    io.on('connection', async (socket) => {
        socket.emit('chat message', "connected");
        console.log('Connected user : ' + socket.id);
        console.log("Recovered: " + socket.recovered);
        socket.on('chat message', async () => {
            let tags = await getalltags();
            socket.emit('chat message', tags);    
        });
        socket.on('disconnect', () => {
            console.log('A user disconnected');
        });
    });
    server.listen(port, () => {
        console.log('Socket started');
    })
}

let include ={role:{select:{id:true,name:true}},coords:{select:{rssi1:true,rssi2:true,rssi3:true,rssi4:true}}};
const select = ["id","name","email","token","role","coords"];
const get = async (req, res, next) => crud.get(req,res,next,"tag",select,include);
const getbyid = async (req, res, next) => crud.getbyid(req,res,next,"tag",select,include);
const deletebyid = async (req, res, next) => crud.deletebyid(req,res,next,"tag");

const getalltags = async (req, res, next) => {
    return crudf.get("tag",{},{coords:true},undefined,{coords:{created_on:"desc"}});
}
const put = async (req, res, next) => {
    try {
        const data = await updatetag(req);
        return sendresponse(res, data, 200,select);
    } catch (e) {
        next(e);
    }
}

const post = async (req,res,next) => {
    try {
        const data = await createtag(req,"TAG");
        return sendresponse(res, data, 201,select);
    } catch (e) {
        next(e);
    }
}

const login = async (req,res,next) => {
    try {
        const { email,password } = req.body;
        let tag = await crudf.get("tag",{email});
        tag = tag[0];
        if(!tag) throw new Error("Invalid email");
        if(bcrypt.compareSync(tag.password,password)) throw new Error("Invalid password");
        let token = await checkAuth.getToken(email,tag.id,tag.role_id);
        tag.token = token;
        await crudf.updatebyid("tag",tag.id,{token});
        sendresponse(res,{...tag,token},201,select);
    } catch (e) {
        next(e);
    }
}

const updatecoords = async (req,res,next) => {
    try {
        const data = await updatecords(req);
        let tags = await getalltags();
        io.emit('chat message', tags);
        return sendresponse(res, data, 200,select);
    } catch (e) {
        next(e);
    }
}

const createtag = async (req,role) => {
    let { password,name,email,token,role_id } = req.body;
    password = bcrypt.hashSync(password, salt);
    role_id = role_id || constants.ROLES[role];
    const body = { password,name,email,token,role_id };
    const required = { email,password,name,role_id };
    return crudf.create("tag",body,required,{email});
}

const updatetag = async (req) => {
    let { password,name,email,token,role_id } = req.body;
    if(password) password = bcrypt.hashSync(password, salt);
    const body = { password,name,email,token,role_id };
    return crudf.updatebyid("tag",req.params.id,body);
}

const updatecords = async (req) => {
    let { xcord,ycord,rssi1,rssi2,rssi3,rssi4 } = req.body;
    await crudf.create("coords",{ rssi1,rssi2,rssi3,rssi4,tag_id:Number(req.params.id) },{ rssi1,rssi2,rssi3,rssi4,tag_id:Number(req.params.id) });
    return crudf.updatebyid("tag",req.params.id,{ xcord,ycord });
}

export default{ get, getbyid, post, put, deletebyid,login,createtag,updatetag,updatecoords,initsocket };