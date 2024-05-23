import crudf from "./crudf.js";
import { sendresponse } from "./utils.js"

const get = async (req, res, next, table,select, include, where, orderby) => {
    try {
        const data = await crudf.get(table, req.query, include, where, orderby);
        return sendresponse(res, data, 200,select);
    } catch (e) {
        next(e);
    }
}

const getbyid = async (req, res, next, table,select, include) => {
    try {
        const data = await crudf.getbyid(table, req.params.id, include);
        if (!data) {
            return next(new Error(`Record with id ${req.params.id} not found in ${table}`));
        }
        return sendresponse(res, data, 200,select);
    } catch (e) {
        next(e);
    }
}

const deletebyid = async (req, res, next, table) => {
    try {
        await crudf.deletebyid(table, req.params.id);
        return sendresponse(res, `Record with id ${req.params.id} deleted successfully from ${table}`, 200,select);
    } catch (e) {
        next(e);
    }
}

const create = async (req, res, next, table, body, required, where) => {
    try {
        await crudf.create(table, body, required, where);
        return sendresponse(res, `Record created successfully in ${table}`, 201,select);
    } catch (e) {
        next(e);
    }
}

const createmany = async (req, res, next, table, body, required) => {
    try {
        await crudf.createmany(table, body, required);
        return sendresponse(res, `Records created successfully in ${table}`, 201,select);
    } catch (e) {
        next(e);
    }
}

const update = async (req, res, next, table, body) => {
    try {
        await crudf.updatebyid(table, req.params.id, body);
        return sendresponse(res, `Record with id ${req.params.id} updated successfully in ${table}`, 200,select);
    } catch (e) {
        next(e);
    }
}


export default { get, getbyid, deletebyid, create, createmany, update};