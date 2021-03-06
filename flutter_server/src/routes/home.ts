import express, { Express, Request, Response } from 'express';
import { Data } from '../interfaces/router';
import { Goods, Banner } from '../model/index';

const router: Express = express();

router.post('/', async (_req: Request, res: Response) => {
  const query = await Goods.findAll();
  const query2 = await Banner.findAll();
  const banner_imgs: any = [];
  const advert_imgs: any = [];
  const category_imgs: any = [];
  const floor_imgs: any = [];
  query2.forEach((_img: { type: number; }) => {
    _img.type === 0 && banner_imgs.push(_img);
    _img.type === 1 && advert_imgs.push(_img);
    _img.type === 2 && category_imgs.push(_img);
    _img.type === 3 && floor_imgs.push(_img);
  })
  const data: Data = {
    code: 0,
    status: 200,
    message: 'success',
    data: {
      query,
      banner_imgs,
      advert_imgs,
      category_imgs,
      floor_imgs
    }
  }
  res.send(data);
})

module.exports = router;