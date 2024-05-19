import helmet from 'helmet'
import cors from 'cors'
import express from 'express'
import initRoutes from "./initializers/initRoutes.js"
import initServer from './initializers/initServer.js'
import { initprisma } from "./initializers/initprisma.js"
import tag from './controllers/tag.js'


const app = express();
app.use(helmet());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.options('*', cors());
initprisma();
initRoutes(app);
initServer(app);
tag.initsocket(app);