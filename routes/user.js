import controller from "../controllers/user.js"
import express from "express";
const router = express.Router()

router
.get("/", controller.get)
.get("/:id", controller.getbyid)
.delete("/:id", controller.deletebyid)
.put("/:id", controller.put)

export default router;