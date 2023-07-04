import Sequelize, { Model } from 'sequelize';

export default class Maritmebase extends Model {
  static init(sequelize) {
    super.init({
      title: {
        type: Sequelize.STRING,
        defaultValue: '',
      },
      lat: {
        type: Sequelize.DOUBLE,
        defaultValue: 0,
      },
      long: {
        type: Sequelize.DOUBLE,
        defaultValue: 0,
      },
    }, {
      sequelize,
    });

    return this;
  }
}
