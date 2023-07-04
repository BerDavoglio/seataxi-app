/* eslint-disable class-methods-use-this */
import Navigator from '../../models/User/Navigator_models';

import Maritmebase from '../../models/CRUD/Maritmebase_models';
import Boattype from '../../models/CRUD/Boattype_models';

class NavigatorController {
  // Creating User:
  async store(req, res) {
    try {
      if (req.body.user_id) {
        return res.status(400).json({ errors: ['Cannot change user_id'] });
      }

      const maritmeId = await Maritmebase.findByPk(req.body.maritme_base_id);
      if (!maritmeId) {
        return res.status(400).json({ errors: ['Maritmebase not Found'] });
      }

      const boatTypeId = await Boattype.findByPk(req.body.boat_type_id);
      if (!boatTypeId) {
        return res.status(400).json({ errors: ['Boattype not Found'] });
      }

      const newNavigator = await Navigator.create({
        user_id: req.userId,
        maritme_base_id: req.body.maritme_base_id,
        boat_type_id: req.body.boat_type_id,
      });

      return res.json(newNavigator);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Show the user itself:
  async show(req, res) {
    try {
      const id = req.userId;
      const navigator = await Navigator.findOne({
        where: { user_id: id },
      });
      if (!navigator) {
        return res.status(400).json({ errors: ['Navigator not Found'] });
      }

      return res.json(navigator);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Update the user:
  async update(req, res) {
    try {
      const id = req.userId;
      if (!id) {
        return res.status(400).json({ errors: ['ID not Found'] });
      }

      const navigator = await Navigator.findOne({
        where: { user_id: req.userId },
      });
      if (!navigator) {
        return res.status(400).json({ errors: ['Navigator not Found'] });
      }

      if (req.body.user_id) {
        return res.status(400).json({ errors: ['Cannot change user_id'] });
      }

      const maritmeId = await Maritmebase.findByPk(req.body.maritme_base_id);
      if (!maritmeId) {
        return res.status(400).json({ errors: ['Maritmebase not Found'] });
      }

      const boatTypeId = await Boattype.findByPk(req.body.boat_type_id);
      if (!boatTypeId) {
        return res.status(400).json({ errors: ['Boattype not Found'] });
      }

      const newData = await navigator.update(req.body);
      return res.json(newData);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }
}

export default new NavigatorController();
