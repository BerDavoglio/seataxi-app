import { Router } from 'express';
import jwtController from '../../controllers/User/jwt_controller';

const router = new Router();

router.post('/', jwtController.store);

export default router;
