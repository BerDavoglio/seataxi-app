export default (req, res, next) => {
  try {
    if (req.userRole !== 'navigator') {
      return res.status(403).json({ errors: ['Just Navigator allowed'] });
    }

    return next();
  } catch (e) {
    return res.status(401).json({ errors: ['Invalid Token'] });
  }
};
