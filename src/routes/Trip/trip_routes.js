import { Router } from 'express';
import tripController from '../../controllers/Trip/trip_controller';

import loginRequired from '../../middlewares/login_required';
import isNavigator from '../../middlewares/is_navigator';

const router = new Router();

router.post('/', loginRequired, tripController.store);
router.get('/navigator/', loginRequired, isNavigator, tripController.indexNavigator);
router.put('/value/:id/', loginRequired, isNavigator, tripController.updateValue);
router.get('/value/:id/', loginRequired, tripController.getValue);
router.put('/value/:id/deny/', loginRequired, tripController.denyValue);
router.put('/accept/:id', loginRequired, tripController.updateAccept);
router.get('/accept/:id/', loginRequired, tripController.getAccept);
router.get('/finish/:id/', loginRequired, tripController.finishTrip);

router.get('/:id/', loginRequired, tripController.indexByPk);
router.get('/user/', loginRequired, tripController.indexUser);

export default router;
