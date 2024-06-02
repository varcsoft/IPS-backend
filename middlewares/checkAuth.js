import jwt from "jsonwebtoken";
import constants from "../utils/constants.js"
import ApiError from "../utils/ApiError.js";
import dotenv from "dotenv";
dotenv.config();
const INVALIDAUTH = 'INVALID AUTH';

const getToken = (email, id, role, time) => {
    return jwt.sign({ email, id: id.toString(), role: !role ? "role" : role }, constants.SECRET, { expiresIn: time ? time + "M" : process.env.JWT_REFRESH_EXPIRATION_DAYS + "d" })
};

const checkToken = (req, res, next) => {
    let { method, originalUrl } = req;
    method = method ? method : "UNDEFINED";
    originalUrl = originalUrl ? originalUrl : "UNDEFINED";
    console.log("REQUEST TYPE : " + method);
    console.log("URL : " + originalUrl);
    let token = req.headers['authorization'];
    if (token) {
        if (token.startsWith('Bearer ')) {
            token = token.slice(7, token.length);
            jwt.verify(token, constants.SECRET, (err, decoded) => {
                if (err) {
                    // prisma.user.update({ where: { id: Number(decoded.id) }, data: { token: "" } });
                    console.log(err);
                    throw new ApiError(401, INVALIDAUTH);
                } else {
                    req.user = decoded;
                    checkuser(req.user, token, next);
                }
            });
        }
    }
    else {
        throw new ApiError(401, INVALIDAUTH);
    }
};

async function checkuser(user, token, next) {
    try {
        if (!user) {
            throw new ApiError(401, INVALIDAUTH);
        }
        next();
    } catch (e) {
        next(e);
    }
}

const isadmin = (req, res, next) => {
    if (req.user.role_id == 5 || req.user.role_id == 6) {
        next();
    }
    else {
        res.status(500).json({ message: 'Only admin can access this page' });
    }
};

const ishost = (req, res, next) => {
    if (req.user.role_id == 4) {
        next();
    }
    else {
        res.status(500).json({ message: 'Only host can access this page' });
    }
};

const issuperadmin = (req, res, next) => {
    if (req.user.role_id == 6) {
        next();
    }
    else {
        res.status(500).json({ message: 'Only superadmin can access this page' });
    }
};

export default { checkToken, isadmin, issuperadmin, ishost, getToken }