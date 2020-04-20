import express, { Express, Request, Response } from 'express';
import { User } from '../model/index';
import { sign, verify} from '../utils/jwt'
import { send } from '../utils/send'
// const base_url = "http://" + config.HOST + ":" + config.PORT + "/images/banner/";

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
      phone: userInfo.userName,
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
router.post('/pay', async (req: Request, res: Response) => {
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

// 购物车操作
router.post('/cart', async (req: Request, res: Response) => {
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

// 确认收货接口
router.post('/receipt', async (req: Request, res: Response) => {
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

module.exports = router;