import controller from "../controllers/role.js"
import express from "express";
const router = express.Router();
router
  .get('/', controller.get)
  .get('/:id', controller.getbyid)
  .post("/", controller.post)
  .put("/:id", controller.put)
  .delete("/:id", controller.deletebyid)
export default router;