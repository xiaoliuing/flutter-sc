import express, { Express, Request, Response } from 'express';
import { Data } from '../interfaces/router';
import { Goods } from '../model/index';

const router: Express = express();

router.post('/', async (_req: Request, res: Response) => {
  const reqQuery: any = _req.body;
  const obj: any = {};
  Object.keys(reqQuery).forEach((item)=>{
    const cate = reqQuery[item];
    if(Boolean(Number(cate))){
      switch(item){
        case 'firstCategoryId': return obj['categroy'] = reqQuery[item];
        case 'secondCategoryId': return obj['sub_categroy'] = reqQuery[item];
        default: return;
      }
    }
  })
  const _query = {
    where: {...obj},
    attributes: ['g_name', 'pre_price', 'price', 's_img', 'goods_id']
  }
  const query: any = await Goods.findAll({
    ..._query
  }).map((_item: { g_name: any; pre_price: any; price: any; s_img: any; goods_id: any; }) => {
    const {g_name, pre_price, price, s_img, goods_id} = _item;
    return {
      'name': g_name,
      'image': s_img,
      'presentPrice': pre_price,
      'goodsId': goods_id,
      'oriPrice': price
    }
  });
  const data: Data = {
    code: 0,
    status: 200,
    message: 'success',
    data: [...query]
  }
  // console.log(data);
  res.send(data);
})

module.exports = router;