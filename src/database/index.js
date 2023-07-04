/* eslint-disable no-console */
import Sequelize from 'sequelize';
import databaseConfig from '../config/database';

import User from '../models/User/User_models';
import Navigator from '../models/User/Navigator_models';
import Trip from '../models/Trip/Trip_models';
import Treinee from '../models/CRUD/Treinee_models';
import Maritmebase from '../models/CRUD/Maritmebase_models';
import Boattype from '../models/CRUD/Boattype_models';

const models = [User, Navigator, Trip, Treinee, Maritmebase, Boattype];
const connection = new Sequelize(databaseConfig);

connection
  .authenticate()
  .then(() => {
    console.log('Connection Complete');
  })
  .catch(() => {
    console.log('Connection Erro');
  });

models.forEach((model) => model.init(connection));
