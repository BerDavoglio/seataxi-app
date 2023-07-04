export default (req, res, next) => {
  try {
    if (req.userRole !== 'admin') {
      return res.status(403).json({ errors: ['Just Admin allowed'] });
    }
    return next();
  } catch (e) {
    return res.status(401).json({ errors: ['Invalid Token'] });
  }
};
