import crud from "../utils/crud.js"
import usercontroller from "./user.js"
let include = { user: { select: { id: true, name: true, email: true } }};

const get = async (req, res, next) => crud.get(req, res, next, "tag", include);
const getbyid = async (req, res, next) => crud.getbyid(req, res, next, "tag", include);
const deletebyid = async (req, res, next) => crud.deletebyid(req, res, next, "tag");

const put = async (req, res, next) => {
    try {
        const { rssi } = req.body;
        const body = { rssi };
        const required = body;
        const user = await usercontroller.updateuser(req);
        crud.create(req, res, next, "tag", { user_id: user.id, ...body }, { user_id: user.id, ...required });
    } catch (e) {
        next(e);
    }
}

const post = async (req, res, next) => {
    try {
        const { rssi } = req.body;
        const body = { rssi };
        const required = body;
        const user = await usercontroller.createuser(req, "tag");
        crud.create(req, res, next, "tag", { user_id: user.id, ...body }, { user_id: user.id, ...required });
    } catch (e) {
        next(e);
    }
}

export default { get, getbyid, post, put, deletebyid };