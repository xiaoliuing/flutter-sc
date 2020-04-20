import express, { Express, Request, Response } from 'express';
import { Data } from '../interfaces/router';
import { Goods } from '../model/index';

const router: Express = express();

router.post('/', async (_req: Request, res: Response) => {
  const goodsId: string = _req.body.goodsId;
  const goodInfo = await Goods.findAll({
    where: {
      goods_id: goodsId
    }
  }).map((_item: any) => {
    const { g_name, pre_price, price, s_img, s_imgs, goods_id } = _item;
    return {
      amount: 10000,
      goodsId: goods_id,
      image1: s_img,
      goodsSerialNumber: 'a1231231212',
      oriPrice: pre_price,
      presentPrice: price,
      shopId: 'bx61g9dh29h3f8g9gf283fh2',
      goodsName: g_name,
      goodsDetail: s_imgs
    }
  });
  const data: Data = {
    code: 0,
    status: 200,
    message: 'success',
    data: {
      goodInfo: goodInfo[0],
    }
  }
  res.send(data);
})

module.exports = router;