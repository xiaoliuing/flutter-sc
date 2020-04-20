import express, { Express, Request, Response } from 'express';
import { send } from '../utils/send';
import { Goods } from '../model/index';
import Sequelize from 'sequelize';
// const base_url = "http://" + config.HOST + ":" + config.PORT + "/images/banner/";

const router: Express = express();

router.post('/', async (req: Request, res: Response) => {
  const opt = req.body;
  var Op = Sequelize.Op;
  const query = await Goods.findAll({ // 模糊查询
    where: {
      [Op.or]: [  // 多个字段的模糊查询
        { g_name: {
          [Op.like]: `%${opt.text}%`
        }},
        { title: {
          [Op.like]: `%${opt.text}%`
        }},
      ]
    },
  });
  send(res, {query})
})


module.exports = router;
