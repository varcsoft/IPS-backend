import ApiError from "./ApiError.js";
import { checkvalues } from "./utils.js";
import { prisma } from "../initializers/initprisma.js";

// Function to handle Prisma errors
const handlePrismaError = (error,table,type) => {
    console.log(error);
    if (error.code === 'P2002') {
        throw new ApiError(400, 'Duplicate entry violates unique constraint');
    } else {
        throw new ApiError(400, `Error in ${type} operation for record in ${table}`);
    }
};

const get = async (table, query, include, where, orderby) => {
    where = where || {};
    where = { ...where, ...query };
    return prisma[table].findMany({ where, include, orderby })
        .catch(e => handlePrismaError(e,table,"get"));
}

const getbyid = async (table, id, include) => {
    return prisma[table].findUnique({ where: { id: Number(id) }, include })
        .catch(e => handlePrismaError(e,table,"get"));
}

const deletebyid = async (table, id) => {
    return prisma[table].delete({ where: { id: Number(id) } })
        .catch(e => handlePrismaError(e,table,"delete"));
}

const updatebyid = async (table, id, body) => {
    return prisma[table].update({ where: { id: Number(id) }, data: body })
        .catch(e => handlePrismaError(e,table,"update"));
}

const updatebywhere = async (table,body, where) => {
    return prisma[table].update({ where, data: body })
        .catch(e => handlePrismaError(e,table,"update"));
}

const create = async (table, body, required, where) => {
    checkvalues(required);
    if (where) {
        const data = await prisma[table].findFirst({ where });
        if (data) {
            throw new ApiError(400, `Record with same ${Object.keys(where).toString()} already exists`);
        }
    }
    return prisma[table].create({ data: { ...body, "created_on": new Date() } })
        .catch(e => handlePrismaError(e,table,"create"));
}

const createmany = async (table, body, required) => {
    checkvalues(required);
    body = body.map((e) => {
        return { ...e, "created_on": new Date() };
    });
    return prisma[table].createMany({ data: body })
        .catch(e => handlePrismaError(e,table,"create"));
}

export default { get, getbyid, deletebyid, create, createmany, updatebyid, updatebywhere };
