import crud from "../utils/crud.js"
import crudf from "../utils/crudf.js";
import { sendresponse } from "../utils/utils.js";
import bcrypt from "bcrypt";
import checkAuth from "../middlewares/checkAuth.js";
import constants from "../utils/constants.js";
const salt = bcrypt.genSaltSync(10);
let include ={role:{select:{id:true,name:true}}};

const get = async (req, res, next) => crud.get(req,res,next,"user",include);
const getbyid = async (req, res, next) => crud.getbyid(req,res,next,"user",include);
const deletebyid = async (req, res, next) => crud.deletebyid(req,res,next,"user");

const put = async (req, res, next) => {
    try {
        const data = await updateuser(req);
        return sendresponse(res, data, 200);
    } catch (e) {
        next(e);
    }
}

const post = async (req,res,next) => {
    try {
        const data = await createuser(req,"USER");
        return sendresponse(res, data, 201);
    } catch (e) {
        next(e);
    }
}

const login = async (req,res,next) => {
    try {
        const { email,password } = req.body;
        const user = await crudf.getbywhere("user",{email});
        if(!user) throw new Error("Invalid email");
        if(bcrypt.compareSync(user.password,password)) throw new Error("Invalid password");
        let token = await checkAuth.getToken(email,user.id,user.role_id);
        user.token = token;
        await crudf.updatebyid("user",user.id,{token});
        delete user.password;
        delete user.token;
        sendresponse(res,{...user,token},200);
    } catch (e) {
        next(e);
    }
}

const createuser = async (req,role) => {
    let { password,name,email,token,role_id } = req.body;
    password = bcrypt.hashSync(password, salt);
    role_id = role_id || constants.ROLES[role];
    const body = { password,name,email,token,role_id };
    const required = { email,password,name,role_id };
    return crudf.create("user",body,required,{email});
}

const updateuser = async (req) => {
    let { password,name,email,token,role_id } = req.body;
    if(password) password = bcrypt.hashSync(password, salt);
    const body = { password,name,email,token,role_id };
    return crudf.updatebyid("user",req.params.id,body);
}

export default{ get, getbyid, post, put, deletebyid,login,createuser,updateuser };