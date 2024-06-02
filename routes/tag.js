import controller from "../controllers/tag.js"
import express from "express";
const router = express.Router();
router
  .get("/", controller.get)
  .post("/", controller.getTag)
  .get('/:id', controller.getbyid)
  .put("/:id/coords", controller.updatecoords)
  .put("/", controller.put)
  .delete("/:id", controller.deletebyid)

export default router;