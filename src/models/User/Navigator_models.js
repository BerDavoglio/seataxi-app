import Sequelize, { Model } from 'sequelize';

export default class Navigator extends Model {
  static init(sequelize) {
    super.init({
      user_id: {
        type: Sequelize.STRING,
      },
      maritme_base_id: {
        type: Sequelize.STRING,
      },
      boat_type_id: {
        type: Sequelize.STRING,
      },
    }, {
      sequelize,
    });

    return this;
  }
}
