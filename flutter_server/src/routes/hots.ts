import express, { Express, Request, Response } from 'express';
import { Data } from '../interfaces/router';
// import config from '../config/index';
import { Goods } from '../model/index';
// const base_url = "http://" + config.HOST + ":" + config.PORT + "/images/banner/";

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

module.exports = router;