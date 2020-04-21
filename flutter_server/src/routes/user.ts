import express, { Express, Request, Response } from 'express';
import { User } from '../model/index';
import { sign, verify} from '../utils/jwt'
import { send } from '../utils/send'

const router: Express = express();

interface ResData {
  token?: string
}

// 登录
router.post('/login', async (req: Request, res: Response) => {
  const userInfo = req.body;
  const _raw: string | undefined = req.headers['www-authenticate'];
  const resData: ResData = {};
  let status: number = 200;
  let code: number = 0;
  const user = await User.findAll({
    where: {
      name_id: userInfo.userName,
      password: userInfo.password
    }
  });
  if(_raw == 'null' || !_raw) {
    if(user[0].phone === userInfo.userName){
      resData.token = sign(String(user[0].id));
    }else {
      code = 1;
      status = 500;
    };
  }
  send(res, {...user[0].dataValues, ...resData}, code, status);
})

// 用户数据更新
router.post('/update', async (req: Request, res: Response) => {
  const userInfo = req.body;
  const _raw: string = req.headers['www-authenticate'] || '';
  const id: string  = verify(_raw);
  const updateObj: any = {};
  Object.keys(userInfo).forEach((key) => {
    if(userInfo[key]){
      updateObj[key] = userInfo[key];
    }
  });
  const query = await User.update({...updateObj}, {where: {id}})
  if(query[0]){
    send(res, {res: 0});
  }else{
    send(res, {res: '更新失败'}, 1, 500);
  }
})

// 支付
router.post('/paied', async (req: Request, res: Response) => {
  const { type='post', paied, cart } = req.body;
  const _raw: string = req.headers['www-authenticate'] || '';
  const id: string  = verify(_raw);
  let query = await User.findAll({where: {id}});
  if(type === 'post'){
    if(query.length){
      const _paied = JSON.parse(query[0].paied || '[]');
      _paied.unshift(paied);
      query = await User.update({
        paied: JSON.stringify(_paied), // 1 已付款，0 已收货,
        cart: JSON.stringify(cart)
      }, {where: {id}})
    }
    send(res, {query});
  }else{
    send(res, {paied: query[0].paied});
  }
})

// 购物车操作
router.post('/cart', async (req: Request, res: Response) => {
  const { cart } = req.body;
  const _raw: string = req.headers['www-authenticate'] || '';
  const id: string  = verify(_raw);
  let query: any;
  if(cart){
    query = await User.update({
      cart: JSON.stringify(cart)
    }, {where: {id}});
  }else{
    query = await User.findAll({where: {id},attributes: ['paied']})
  }
  if(query.length){
    send(res, {paied: query[0]});
  }else{
    send(res, {}, 1, 500);
  }
})

// 确认收货接口
router.post('/received', async (req: Request, res: Response) => {
  const { type='post', paied, received } = req.body;
  const _raw: string = req.headers['www-authenticate'] || '';
  const id: string  = verify(_raw);
  let query = await User.findAll({where: {id}});
  if(type === 'post'){
    if(query.length){
      const _received= JSON.parse(query[0].received || '[]');
      _received.unshift(received);
      query = await User.update({
        paied: JSON.stringify(paied), // 1 已付款，0 已收货,
        received: JSON.stringify(_received)
      }, {where: {id}})
    }
    send(res, {query});
  }else{
    console.log(query);
    send(res, {received: query[0].received});
  }
})

// 删除已收货商品接口
router.post('/del', async (req: Request, res: Response) => {
  const { received } = req.body;
  const _raw: string = req.headers['www-authenticate'] || '';
  const id: string  = verify(_raw);
  let query = await User.findAll({where: {id}});
    if(query.length){
      query = await User.update({
        received: JSON.stringify(received)
      }, {where: {id}})
    }
    query.length ? send(res, {query}) : send(res, {}, 1, 100);
})

module.exports = router;
