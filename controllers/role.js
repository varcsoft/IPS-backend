import crud from "../utils/crud.js"
let include ={};
const select = ["id","name"];

const get = async (req, res, next) => crud.get(req,res,next,"role",select,include);
const getbyid = async (req, res, next) => crud.getbyid(req,res,next,"role",select,include);
const deletebyid = async (req, res, next) => crud.deletebyid(req,res,next,"role");

const put = async (req, res, next) => {
    let { name } = req.body;
    const body = { name };
    const required = body;
    crud.update(req,res,next,"role",body)
}

const post = async (req, res, next) => {
    let { name } = req.body;
    const body = { name:req.body.name };
    const required = body;
    crud.create(req,res,next,"role",body,required,{name});
}

export default{ get, getbyid, post, put, deletebyid };