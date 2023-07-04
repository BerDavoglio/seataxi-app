module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('trips', {
      id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
      },
      user_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
      },
      navigator_id: {
        type: Sequelize.INTEGER,
        allowNull: true,
      },
      origin_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
      },
      destination_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
      },
      boattype_id: {
        type: Sequelize.INTEGER,
        allowNull: false,
      },
      people: {
        type: Sequelize.INTEGER,
        allowNull: false,
      },
      method_payment: {
        type: Sequelize.ENUM('dinheiro', 'credito', 'debito'),
        allowNull: false,
      },
      private: {
        type: Sequelize.BOOLEAN,
        allowNull: true,
      },
      value: {
        type: Sequelize.DOUBLE,
        allowNull: true,
      },
      acceptance: {
        type: Sequelize.BOOLEAN,
        allowNull: true,
      },
      finished: {
        type: Sequelize.BOOLEAN,
        allowNull: false,
      },
      created_at: {
        type: Sequelize.DATE,
        allowNull: false,
      },
      updated_at: {
        type: Sequelize.DATE,
        allowNull: false,
      },
    });
  },

  down: async (queryInterface) => {
    await queryInterface.dropTable('trips');
  },
};
