import express from 'express';
import dotenv from 'dotenv';

import './database';

import userRoutes from './routes/User/user_routes';
import jwtRoutes from './routes/User/jwt_routes';
import navigatorRoutes from './routes/User/navigator_routes';
import tripRoutes from './routes/Trip/trip_routes';
import crudRoutes from './routes/CRUD/crud_routes';

dotenv.config();

class App {
  constructor() {
    this.app = express();
    this.middlewares();
    this.routes();
  }

  middlewares() {
    this.app.use(express.urlencoded({ extended: true }));
    this.app.use(express.json());
  }

  routes() {
    this.app.use('/users/', userRoutes);
    this.app.use('/jwt/', jwtRoutes);
    this.app.use('/navigator/', navigatorRoutes);

    this.app.use('/trip/', tripRoutes);
    this.app.use('/crud/', crudRoutes);
  }
}

export default new App().app;
