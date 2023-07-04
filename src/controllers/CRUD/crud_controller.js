/* eslint-disable class-methods-use-this */
import Boattype from '../../models/CRUD/Boattype_models';
import Maritmebase from '../../models/CRUD/Maritmebase_models';
import Treinee from '../../models/CRUD/Treinee_models';

class CrudController {
  // BOATTYPE
  async storeBoattype(req, res) {
    try {
      const newBoattype = await Boattype.create(req.body);

      return res.json(newBoattype);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async indexBoattype(req, res) {
    try {
      const boattype = await Boattype.findAll();
      if (!boattype) {
        return res.status(400).json({ errors: ['BoatType not Found'] });
      }

      return res.json(boattype);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async showBoattype(req, res) {
    try {
      const boattype = await Boattype.findByPk(req.params.id);
      if (!boattype) {
        return res.status(400).json({ errors: ['BoatType not Found'] });
      }

      return res.json(boattype);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async updateBoattype(req, res) {
    try {
      const boattype = await Boattype.findByPk(req.params.id);
      if (!boattype) {
        return res.status(400).json({ errors: ['Boattype not Found'] });
      }

      const newData = await boattype.update(req.body);
      return res.json(newData);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async deleteBoattype(req, res) {
    try {
      const boattype = await Boattype.findByPk(req.params.id);
      if (!boattype) {
        return res.status(400).json({ errors: ['Boattype not Found'] });
      }

      await boattype.destroy();
      return res.json({ message: 'Boattype has been Deleted' });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // MARITME BASES
  async storeMaritmebase(req, res) {
    try {
      const newMaritmebase = await Maritmebase.create(req.body);

      return res.json(newMaritmebase);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async indexMaritmebase(req, res) {
    try {
      const maritmebase = await Maritmebase.findAll();
      if (!maritmebase) {
        return res.status(400).json({ errors: ['Maritmebase not Found'] });
      }

      return res.json(maritmebase);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async showMaritmebase(req, res) {
    try {
      const maritmebase = await Maritmebase.findByPk(req.params.id);
      if (!maritmebase) {
        return res.status(400).json({ errors: ['Maritmebase not Found'] });
      }

      return res.json(maritmebase);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async updateMaritmebase(req, res) {
    try {
      const maritmebase = await Maritmebase.findByPk(req.params.id);
      if (!maritmebase) {
        return res.status(400).json({ errors: ['Maritmebase not Found'] });
      }

      const newData = await maritmebase.update(req.body);
      return res.json(newData);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async deleteMaritmebase(req, res) {
    try {
      const maritmebase = await Maritmebase.findByPk(req.params.id);
      if (!maritmebase) {
        return res.status(400).json({ errors: ['Maritmebase not Found'] });
      }

      await maritmebase.destroy();
      return res.json({ message: 'Maritmebase has been Deleted' });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  // TReINEE
  async storeTreinee(req, res) {
    try {
      const newTreinee = await Treinee.create(req.body);

      return res.json(newTreinee);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async indexTreinee(req, res) {
    try {
      const treinee = await Treinee.findAll();
      if (!treinee) {
        return res.status(400).json({ errors: ['Treinee not Found'] });
      }

      return res.json(treinee);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async showTreinee(req, res) {
    try {
      const treinee = await Treinee.findByPk(req.params.id);
      if (!treinee) {
        return res.status(400).json({ errors: ['Treinee not Found'] });
      }

      return res.json(treinee);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async updateTreinee(req, res) {
    try {
      const treinee = await Treinee.findByPk(req.params.id);
      if (!treinee) {
        return res.status(400).json({ errors: ['Treinee not Found'] });
      }

      const newData = await treinee.update(req.body);
      return res.json(newData);
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }

  async deleteTreinee(req, res) {
    try {
      const treinee = await Treinee.findByPk(req.params.id);
      if (!treinee) {
        return res.status(400).json({ errors: ['Treinee not Found'] });
      }

      await treinee.destroy();
      return res.json({ message: 'Treinee has been Deleted' });
    } catch (err) {
      return res.status(400).json({ errors: err.message });
    }
  }
}

export default new CrudController();
