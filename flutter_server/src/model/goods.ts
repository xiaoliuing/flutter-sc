import { Model, DataTypes } from 'sequelize';
import { sequelize } from './sequelize';
// import config from '../config/index';
// const base_url = "http://" + config.HOST + ":" + config.PORT + "/images/goods/";
class Goods extends Model{}

Goods.init({
  g_name: DataTypes.STRING, // 商品名称
  pre_price: DataTypes.BIGINT, // 市场价格
  price: DataTypes.BIGINT, // 现在价格
  categroy: DataTypes.STRING, // 一级分类 
  sub_categroy: DataTypes.STRING, // 二级分类，每个商品必有一个二级分类
  s_img: DataTypes.STRING, // 商品展示列表的图片
  s_imgs: DataTypes.STRING, // 商品详情多图滚动
  type: DataTypes.BIGINT, // 商品类型 1 
  title: DataTypes.STRING, // 商品标题
  create_id: DataTypes.STRING, // 商品编号
  g_size: DataTypes.STRING, // 尺码
  g_try: DataTypes.STRING,  // 试穿信息
  goods_id: DataTypes.STRING,
}, { sequelize, modelName: 'goods' });

// sequelize.sync()
//   .then(() => Goods.create({
//     g_name: 'sdad', // 商品名称
//     pre_price: 21, // 市场价格
//     price: 20, // 现在价格
//     categroy: 3, // 一级分类 1~10
//     sub_categroy: 2, // 二级分类
//     s_img: `${base_url}001/cover.jpeg`, // 商品展示列表的图片
//     s_imgs: '<img width="100%" height="auto" alt="" src="' + base_url + '001/1.jpg" />' + 
//       '<img width="100%" height="auto" alt="" src="' + base_url + '001/2.jpg" />' +
//       '<img width="100%" height="auto" alt="" src="' + base_url + '001/3.jpg" />' +
//       '<img width="100%" height="auto" alt="" src="' + base_url + '001/4.jpg" />' +
//       '<img width="100%" height="auto" alt="" src="' + base_url + '001/5.jpg" />', // 商品详情多图滚动
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