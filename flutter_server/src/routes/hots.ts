import express, { Express, Request, Response } from 'express';
import { Data } from '../interfaces/router';
import { Goods, Tag } from '../model/index';

const router: Express = express();

router.post('/', async (_req: Request, res: Response) => {
  // const id: Number = req.query.id;
  const query = await Goods.findAll();
  const data: Data = {
    code: 0,
    status: 200,
    message: 'success',
    data: {
      query,
    }
  }
  res.send(data);
})

router.post('/hottags', async (req: Request, res: Response) => {
  const { type } = req.body;
  const query = await Tag.findAll({where: {type}});
  const data: Data = {
    code: 0,
    status: 200,
    message: 'success',
    data: {
      query,
    }
  }
  res.send(data);
})

module.exports = router;