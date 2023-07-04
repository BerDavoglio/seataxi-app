import jwt from 'jsonwebtoken';

import User from '../../models/User/User_models';

class JWTController {
  // Make the Token for User
  async store(req, res) {
    const {
      email = '',
      password = '',
    } = req.body;
    if (!email || !password) {
      res.status(401)
        .json({ errors: ['Unauthorized'] });
    }

    const user = await User.findOne({ where: { email } });
    if (!user) {
      res.status(401)
        .json({ errors: ['User does not exist!'] });
    }

    if (!user.email_confirmed) {
      res.status(401)
        .json({ errors: ['Email not Confirmed!'] });
    }

    if (!(await user.passwordIsValid(password))) {
      res.status(401)
        .json({ errors: ['Wrong password'] });
    }

    const {
      id,
      role,
    } = user;
    const token = jwt.sign({
      id,
      email,
      role,
    }, process.env.TOKEN_SECRET, {
      expiresIn: process.env.TOKEN_EXPIRATION,
    });
    res.json({ token });
  }
}

export default new JWTController();
