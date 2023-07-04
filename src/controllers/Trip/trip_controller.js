/* eslint-disable class-methods-use-this */
import Trip from '../../models/Trip/Trip_models';

import Navigator from '../../models/User/Navigator_models';

class TripController {
  // Create Trip
  async store(req, res) {
    try {
      if (
        req.body.acceptance ||
        req.body.value ||
        req.body.user_id ||
        req.body.navigator_id ||
        req.body.finished
      ) {
        return res.status(401).json({ errors: ['Unauthorized'] });
      }

      const newNavigator = await Trip.create({
        user_id: req.userId,
        origin_id: req.body.origin_id,
        destination_id: req.body.destination_id,
        boattype_id: req.body.boattype_id,
        people: req.body.people,
        method_payment: req.body.method_payment,
        private: req.body.private,
      });

      return res.json(newNavigator);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Show to Navigator all the Trips:
  async indexNavigator(req, res) {
    try {
      const navigator = await Navigator.findOne({
        where: { user_id: req.userId },
      });
      if (!navigator) {
        return res.status(400).json({ errors: ['Navigator not Found'] });
      }

      const trips = await Trip.findAll({
        where: {
          origin_id: navigator.maritme_base_id,
          finished: false,
        },
      });
      if (!trips) {
        return res.status(400).json({ errors: ['Trips not Found'] });
      }

      return res.json(trips);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Update the user:
  async updateValue(req, res) {
    try {
      const trip = await Trip.findByPk(req.params.id);
      if (!trip) {
        return res.status(400).json({ errors: ['Trip not Found'] });
      }

      const newData = await Trip.update({
        navigator_id: req.userId,
        value: req.body.value,
      });
      return res.json(newData);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Show the user itself:
  async getValue(req, res) {
    try {
      const trip = await Trip.findByPk(req.params.id);
      if (!trip) {
        return res.status(400).json({ errors: ['Trip not Found'] });
      }

      if (trip.user_id !== req.userId) {
        return res.status(400).json({
          message: 'Cannot see if this trip have a value because its not yours',
        });
      }

      if (trip.value === -1) {
        return res.status(269).json({ message: 'Value not selecioned' });
      }

      return res.json(trip);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Update the user:
  async denyValue(req, res) {
    try {
      const trip = await Trip.findByPk(req.params.id);
      if (!trip) {
        return res.status(400).json({ errors: ['Trip not Found'] });
      }

      if (trip.user_id !== req.userId) {
        return res
          .status(400)
          .json({ errors: ['Cannot deny a trip that is not yours'] });
      }

      await Trip.update({
        navigator_id: -1,
        value: -1,
      });

      return res.json({ message: 'Trip denied with success' });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Update the user:
  async updateAccept(req, res) {
    try {
      const trip = await Trip.findByPk(req.params.id);
      if (!trip) {
        return res.status(400).json({ errors: ['Trip not Found'] });
      }

      if (trip.user_id !== req.userId) {
        return res
          .status(400)
          .json({ errors: ['Cannot accept a trip that is not yours'] });
      }

      const newData = await Trip.update({
        acceptance: true,
      });
      return res.json(newData);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Show the user itself:
  async getAccept(req, res) {
    try {
      const trip = await Trip.findByPk(req.params.id);
      if (!trip) {
        return res.status(400).json({ errors: ['Trip not Found'] });
      }

      if (trip.acceptance === false) {
        return res.status(269).json({ message: 'Trip not Accepted' });
      }

      return res.json(trip);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Update the user:
  async finishTrip(req, res) {
    try {
      const trip = await Trip.findByPk(req.params.id);
      if (!trip) {
        return res.status(400).json({ errors: ['Trip not Found'] });
      }

      if (trip.user_id !== req.userId) {
        return res
          .status(400)
          .json({ errors: ['Cannot finish a trip that is not yours'] });
      }

      const newData = await Trip.update({
        finished: true,
      });
      return res.json(newData);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Show the user itself:
  async indexByPk(req, res) {
    try {
      const trip = await Trip.findByPk(req.params.id);
      if (!trip) {
        return res.status(400).json({ errors: ['Trip not Found'] });
      }

      return res.json(trip);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // Show to Navigator all the Trips:
  async indexUser(req, res) {
    try {
      const trips = await Trip.findAll({
        where: {
          user_id: req.userId,
          finished: false,
        },
      });
      if (!trips) {
        return res.status(400).json({ errors: ['Trips not Found'] });
      }

      return res.json(trips);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }
}

export default new TripController();
