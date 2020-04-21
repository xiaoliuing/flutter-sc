import { Model, DataTypes } from 'sequelize';
import { sequelize } from './sequelize';
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

export {
  Goods
}