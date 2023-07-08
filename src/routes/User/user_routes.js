import { Router } from 'express';
import userController from '../../controllers/User/user_controller';

import loginRequired from '../../middlewares/login_required';
import isAdmin from '../../middlewares/is_admin';

const router = new Router();

router.post('/', userController.store); // Create a User
router.get('/admin/', loginRequired, isAdmin, userController.index); // Get all Users (NEED TO BE ADMIN)
router.get('/', loginRequired, userController.show); // Get User Itself
router.put('/', loginRequired, userController.update); // Update a User
router.put('/password/', loginRequired, userController.updatePass); // Update Password
router.delete('/', loginRequired, userController.delete); // Delete a User

router.put('/confirmateEmail/:id', userController.confirmateEmail);
router.put('/confirmateNavigator/:id', loginRequired, isAdmin, userController.confirmateNavigator);

router.get('/navigators/:notconfirmed', loginRequired, isAdmin, userController.indexNavigators);

export default router;
