/* eslint-disable class-methods-use-this */
/* eslint-disable camelcase */
import User from '../../models/User/User_models';

class UserController {
  // Creating User:
  async store(req, res) {
    try {
      if (req.body.role || req.body.email_confirmed) {
        return res.status(401)
          .json({ errors: ['Unauthorized'] });
      }

      // VERIFICAR CPF
      // VERIFICAR CELL

      const newUser = await User.create(req.body);
      const {
        photo,
        name,
        email,
        cpf,
        gender,
        role,
      } = newUser;

      // Send email for confirmation

      return res.json({
        photo,
        name,
        email,
        cpf,
        gender,
        role,
      });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Show all users (NEED COORDINATOR/ADMIN PROTECTION):
  async index(req, res) {
    try {
      const users = await User.findAll({
        attributes: ['id', 'name', 'email', 'cpf', 'role', 'gender', 'email_confirmed', 'created_at'],
      });

      return res.json(users);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Show the user itself:
  async show(req, res) {
    try {
      const user = await User.findByPk(req.userId);
      if (!user) {
        return res.status(400)
          .json({ errors: ['User not Found'] });
      }

      const {
        photo,
        name,
        email,
        cpf,
        role,
        gender,
      } = user;
      return res.json({
        photo,
        name,
        email,
        cpf,
        role,
        gender,
      });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Update the user:
  async update(req, res) {
    try {
      const id = req.userId;
      if (!id) {
        return res.status(400)
          .json({ errors: ['ID not Found'] });
      }

      const user = await User.findByPk(id);
      if (!user) {
        return res.status(400)
          .json({ errors: ['User not Found'] });
      }

      if (req.body.password || req.body.role) {
        return res.status(401)
          .json({ errors: ['Unauthorized'] });
      }

      // SE TIVER req.body.cpf, VERIFICAR CPF

      const newData = await user.update(req.body);
      const {
        photo,
        name,
        email,
        cpf,
        role,
        gender,
      } = newData;
      return res.json({
        photo,
        name,
        email,
        cpf,
        role,
        gender,
      });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Update the user:
  async updatePass(req, res) {
    try {
      const id = req.userId;
      if (!id) {
        return res.status(400)
          .json({ errors: ['ID not Found'] });
      }

      const user = await User.findByPk(id);
      if (!user) {
        return res.status(400)
          .json({ errors: ['User not Found'] });
      }

      if (req.body.role) {
        return res.status(401)
          .json({ errors: ['Unauthorized'] });
      }

      await user.update({
        password: req.body.password,
      });
      return res.json({ message: 'Password has been changed!' });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Delete User:
  async delete(req, res) {
    try {
      const id = req.userId;
      if (!id) {
        return res.status(400)
          .json({ errors: ['ID not Found'] });
      }

      const user = await User.findByPk(id);
      if (!user) {
        return res.status(400)
          .json({ errors: ['User not Found'] });
      }

      await user.destroy();
      return res.json({ message: 'User has been Deleted' });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Update User to Confirmate Email:
  async confirmateEmail(req, res) {
    try {
      const { id } = req.params;
      if (!id) {
        return res.status(400)
          .json({ errors: ['ID not Found'] });
      }

      const user = await User.findByPk(id);
      if (!user) {
        return res.status(400)
          .json({ errors: ['User not Found'] });
      }

      await user.update({
        email_confirmed: true,
      });

      return res.json({
        message: 'Email Confirmed',
      });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Update User to Confirmate Email:
  async confirmateNavigator(req, res) {
    try {
      const { id } = req.params;
      if (!id) {
        return res.status(400)
          .json({ errors: ['ID not Found'] });
      }

      const user = await User.findByPk(id);
      if (!user) {
        return res.status(400)
          .json({ errors: ['User not Found'] });
      }

      await user.update({
        navigator_confirm: true,
      });

      return res.json({
        message: 'Navigator Confirmed',
      });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }
}

export default new UserController();
