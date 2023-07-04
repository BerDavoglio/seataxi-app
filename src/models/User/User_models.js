/* eslint-disable no-param-reassign */
import Sequelize, { Model } from 'sequelize';
import bcryptjs from 'bcryptjs';

export default class User extends Model {
  static init(sequelize) {
    super.init({
      name: {
        type: Sequelize.STRING,
        defaultValue: '',
        validate: {
          len: {
            args: [3, 100],
            msg: 'NAME is invalid',
          },
        },
      },
      email: {
        type: Sequelize.STRING,
        defaultValue: '',
        validate: {
          isEmail: {
            msg: 'EMAIL is invalid',
          },
        },
      },
      photo: {
        type: Sequelize.STRING,
        defaultValue: '',
      },
      cpf: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      cep: {
        type: Sequelize.STRING,
        defaultValue: 0,
      },
      cell: {
        type: Sequelize.INTEGER,
        defaultValue: 0,
      },
      role: {
        type: Sequelize.ENUM('user', 'navigator', 'admin'),
        defaultValue: 'user',
      },
      gender: {
        type: Sequelize.ENUM('male', 'female', 'nonbinary'),
      },
      password_hash: {
        type: Sequelize.STRING,
        defaultValue: '',
      },
      password: {
        type: Sequelize.VIRTUAL,
        defaultValue: '',
        validate: {
          len: {
            args: [3, 25],
            msg: 'PASSWORD is invalid',
          },
        },
      },
      email_confirmed: {
        type: Sequelize.BOOLEAN,
        defaultValue: false,
      },
      documents_confirmed: {
        type: Sequelize.BOOLEAN,
        defaultValue: false,
      },
    }, {
      sequelize,
    });

    this.addHook('beforeSave', async (user) => {
      if (user.password) {
        user.password_hash = await bcryptjs.hash(user.password, 8);
      }
    });

    return this;
  }

  passwordIsValid(password) {
    return bcryptjs.compare(password, this.password_hash);
  }
}
