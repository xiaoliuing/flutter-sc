import { Model, DataTypes } from 'sequelize';
import { sequelize } from './sequelize';
import config from '../config/index';
const base_url = "http://" + config.HOST + ":" + config.PORT + "/images/banner/";
class Goods extends Model{}

Goods.init({
  g_name: DataTypes.STRING, // 商品名称
  pre_price: DataTypes.BIGINT, // 市场价格
  price: DataTypes.BIGINT, // 现在价格
  categroy: DataTypes.BIGINT, // 一级分类 1~10
  sub_categroy: DataTypes.BIGINT, // 二级分类
  s_img: DataTypes.STRING, // 商品展示列表的图片
  s_imgs: DataTypes.STRING, // 商品详情多图滚动
  type: DataTypes.BIGINT, // 商品类型 1 推荐  |  2 火爆  | 3 普通
  title: DataTypes.STRING, // 商品标题
  create_id: DataTypes.STRING, // 商品编号
  g_size: DataTypes.STRING, // 尺码
  g_try: DataTypes.STRING  // 试穿信息
}, { sequelize, modelName: 'goods' });

// sequelize.sync()
//   .then(() => Goods.create({
//     g_name: 'sdad', // 商品名称
//     pre_price: 21, // 市场价格
//     price: 20, // 现在价格
//     categroy: 3, // 一级分类 1~10
//     sub_categroy: 2, // 二级分类
//     s_img: `${base_url}1.jpeg`, // 商品展示列表的图片
//     s_imgs: `[${base_url}1.jpeg,${base_url}2.jpeg,${base_url}3.jpeg,${base_url}4.jpeg]`, // 商品详情多图滚动
//     type: 1, // 商品类型 1 推荐  |  2 火爆  | 3 普通
//     title: 'aewef', // 商品标题
//     create_id: 'FE23424234', // 商品编号
//     g_size: '2323', // 尺码
//     g_try: 'wefewfewf' // 试穿信息
//   }))
//   .then((result: Goods) => {
//     console.log(result.toJSON());
//   });

export {
  Goods
}