import crud from "../utils/crud.js"
import crudf from "../utils/crudf.js";
let include = {};
const select = ["id", "name", "bssid", "xcord", "ycord"];

const get = async (req, res, next) => crud.get(req, res, next, "anchor", select, include);
const getbyid = async (req, res, next) => crud.getbyid(req, res, next, "anchor", select, include);
const deletebyid = async (req, res, next) => crud.deletebyid(req, res, next, "anchor");

const put = async (req, res, next) => {
    let { name, bssid, xcord, ycord } = req.body;
    const body = { name, bssid, xcord, ycord };
    const required = body;
    crud.update(req, res, next, "anchor", body)
}

const post = async (req, res, next) => {
    let { name, bssid, xcord, ycord } = req.body;
    const anchors = await crudf.get("anchor");
    if (anchors.length > 4) return res.status(400).json({ message: "Maximum(4) Anchors reached. Kindly delete some anchors to add new ones." });
    const body = { name, bssid, xcord, ycord };
    const required = body;
    crud.create(req, res, next, "anchor", body, required, { bssid });
}

export default { get, getbyid, post, put, deletebyid };