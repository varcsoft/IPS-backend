import controller from "../controllers/tag.js"
import express from "express";
const router = express.Router();
router
  .get("/", controller.get)
  .get('/:id', controller.getbyid)
  .put("/:id/coords", controller.updatecoords)
  .put("/:id", controller.put)
  .delete("/:id", controller.deletebyid)

export default router;