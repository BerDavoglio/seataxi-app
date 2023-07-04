import { Router } from 'express';
import navigatorController from '../../controllers/User/navigator_controller';

import loginRequired from '../../middlewares/login_required';
import isNavigator from '../../middlewares/is_navigator';

const router = new Router();

router.post('/', loginRequired, isNavigator, navigatorController.store); // Create a Trip
router.get('/', loginRequired, isNavigator, navigatorController.show); // Get one Trips
router.put('/', loginRequired, isNavigator, navigatorController.update); // Update a Trip

export default router;
