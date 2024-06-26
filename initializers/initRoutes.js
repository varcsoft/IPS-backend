import errorHandler from '../middlewares/error.js';
import authRoutes from "../routes/auth.js";
import ApiError from '../utils/ApiError.js';
import auth from "../middlewares/checkAuth.js";
import tagRoutes from "../routes/tag.js";
import roleRoutes from "../routes/role.js";
import anchorRoutes from "../routes/anchor.js";

export default (app) => {
    app.get('/', async (req, res) => res.json('Hello! IPS WELCOMES YOU'));
    app.get('/ping', async (req, res) => res.json('pong!'));

    app.use("/auth", authRoutes);
    app.use(auth.checkToken);
    app.use("/tag", tagRoutes);
    // app.use("/mytag",)
    app.use("/role", roleRoutes);
    app.use("/anchor", anchorRoutes);

    app.use((req, res, next) => next(new ApiError(404, 'Not found')));
    app.use(errorHandler);
}