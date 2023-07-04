/* eslint-disable no-console */

import app from './app';
import User from './models/User/User_models';

const { execSync } = require('child_process');

app.listen(process.env.APP_PORT, async () => {
  try {
    await execSync('npx sequelize db:migrate');
  } catch (e) {
    console.log('Server already has been migrated');
  }

  const user = await User.findByPk(1);
  if (!user) {
    await User.create({
      name: 'admin',
      email: 'admin@gmail.com',
      photo: '',
      cpf: 123,
      cep: '',
      gender: 'nonbinary',
      password: 'admin123',
      role: 'admin',
      email_confirmed: true,
      documents_confirmed: true,
    });
  } else {
    console.log('Admin already has been created');
  }

  console.log('Started!');
});
