import { Router } from 'express';
import crudController from '../../controllers/CRUD/crud_controller';

import loginRequired from '../../middlewares/login_required';
import isAdmin from '../../middlewares/is_admin';

const router = new Router();

router.post('/boattype/', loginRequired, isAdmin, crudController.storeBoattype);
router.get('/:id/boattype/', loginRequired, isAdmin, crudController.showBoattype);
router.get('/boattype/', loginRequired, crudController.indexBoattype);
router.put('/boattype/:id/', loginRequired, isAdmin, crudController.updateBoattype);
router.delete('/boattype/:id/', loginRequired, isAdmin, crudController.deleteBoattype);

router.post('/maritmebase/', loginRequired, isAdmin, crudController.storeMaritmebase);
router.get('/:id/maritmebase/', loginRequired, crudController.showMaritmebase);
router.get('/maritmebase/', loginRequired, crudController.indexMaritmebase);
router.put('/maritmebase/:id', loginRequired, isAdmin, crudController.updateMaritmebase);
router.delete('/maritmebase/:id/', loginRequired, isAdmin, crudController.deleteMaritmebase);

router.post('/treinee/', loginRequired, crudController.storeTreinee);
router.get('/:id/treinee/', loginRequired, crudController.showTreinee);
router.get('/treinee/', loginRequired, crudController.indexTreinee);
router.put('/treinee/:id', loginRequired, crudController.updateTreinee);
router.delete('/treinee/:id/', loginRequired, crudController.deleteTreinee);

export default router;
