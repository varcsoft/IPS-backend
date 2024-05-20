import crud from "../utils/crud.js"
let include ={};
const select = ["id","name"];

const get = async (req, res, next) => crud.get(req,res,next,"role",select,include);
const getbyid = async (req, res, next) => crud.getbyid(req,res,next,"role",select,include);
const deletebyid = async (req, res, next) => crud.deletebyid(req,res,next,"role",select);

const put = async (req, res, next) => {
    const { name } = req.body;
    const body = { name };
    const required = body;
    crud.update(req,res,next,"role",select,body)
}

const post = async (req, res, next) => {
    const { name } = req.body;
    const body = { name };
    const required = body;
    crud.create(req,res,next,"role",select,body,required,{name});
}

export default{ get, getbyid, post, put, deletebyid };