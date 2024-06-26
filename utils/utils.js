import ApiError from '../utils/ApiError.js';

function checkvalues(required) {
    if (Object.values(required).includes(undefined)) {
        throw new ApiError(400, 'Please provide required values '+Object.keys(required).toString());
    }
}

function sendresponse(res, data, status,select) {
    let finaldata;
    if(data==null || !data || data=={} || data.length==0) {
        finaldata = {"message": "data not found", "data": {}, "count": 0 };
        status=404;
    } else if (Array.isArray(data)) {
        if (select) {
            finaldata = {
                "message": "success",
                "data": data.map(item => {
                    return Object.keys(item)
                        .filter(key => select.includes(key))
                        .reduce((obj, key) => {
                            obj[key] = item[key];
                            return obj;
                        }, {});
                })
            };
        } else {
            finaldata = {"message": "success", "data": data, "count": data.length };
        }
    } else {
        if(select){
            finaldata = {
                "message": "success",
                "data": Object.keys(data)
                    .filter(key => select.includes(key))
                    .reduce((obj, key) => {
                        obj[key] = data[key];
                        return obj;
                    }, {})
            };
        } else {
            finaldata = {"message": "success", "data": data };
        }
    }
    console.log("data:" + JSON.stringify(data));
    log("success",status);
    return res.status(status).json(finaldata);
}

function log(message,status) {
    console.log("Status: "+status+", message: "+message);
}

function generaterandomcode() {
    const code = Math.floor(100000 + Math.random() * 900000); // Generates a 4-digit code
    return code.toString();
}

export { checkvalues, sendresponse,log,generaterandomcode };