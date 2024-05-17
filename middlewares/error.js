import { log } from "../utils/utils.js";
const errorHandler = (err, req, res, next) => {
    let { statusCode, message,isOperational } = err;
    // message=isOperational ? message : "Something went wrong";
    message= message ? message : "Something went wrong!";
    statusCode=statusCode ? statusCode : 500;
    log("error",statusCode);
    console.log(err.stack);
    res.status(statusCode).json({ message:"error",data:message });
}

export default errorHandler;