import jwt from 'jsonwebtoken';
import User from '../models/User/User_models';

export default async (req, res, next) => {
  const { authorization } = req.headers;
  if (!authorization) {
    res.status(401)
      .json({ errors: ['Login Required'] });
  }

  const [, token] = authorization.split(' ');

  try {
    const data = jwt.verify(token, process.env.TOKEN_SECRET);
    const {
      id,
      email,
      role,
    } = data;

    const user = await User.findOne({
      where: {
        id,
        email,
      },
    });
    if (!user) {
      return res.status(401)
        .json({ errors: ['Invalid Token'] });
    }

    if (!user.email_confirmed) {
      return res.status(403)
        .json({ errors: ['Email not Confirmed'] });
    }

    if (user.role === 'navigator' && !user.documents_confirmed) {
      return res.status(403)
        .json({ errors: ['Documents not Confirmed'] });
    }

    if (user.role === 'navigator' || !user.documents_confirmed) {
      return res.status(403)
        .json({ errors: ['Navigator please send your documents by e-mail!'] });
    }

    req.userId = id;
    req.userEmail = email;
    req.userRole = role;

    return next();
  } catch (e) {
    return res.status(401)
      .json({ errors: ['Invalid Token'] });
  }
};
