import Sequelize, { Model } from 'sequelize';

export default class Trip extends Model {
  static init(sequelize) {
    super.init({
      user_id: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      navigator_id: {
        type: Sequelize.INTEGER,
        defaultValue: -1,
      },
      origin_id: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      destination_id: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      boattype_id: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      people: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      method_payment: {
        type: Sequelize.ENUM('dinheiro', 'credito', 'debito'),
        defaultValue: 'dinheiro',
      },
      private: {
        type: Sequelize.BOOLEAN,
        defaultValue: false,
      },
      value: {
        type: Sequelize.DOUBLE,
        defaultValue: -1,
      },
      acceptance: {
        type: Sequelize.BOOLEAN,
        defaultValue: false,
      },
      finished: {
        type: Sequelize.BOOLEAN,
        defaultValue: false,
      },
    }, {
      sequelize,
    });

    return this;
  }
}
