import { Model, DataTypes } from 'sequelize';
import { sequelize } from './sequelize';
import config from '../config/index';
const base_url = "http://" + config.HOST + ":" + config.PORT + "/images/";
class Banner extends Model{} // 存储商品以外的图片路径

Banner.init({
  img_url: DataTypes.STRING, // 图片路径
  type: DataTypes.BIGINT, // 0 轮播图 | 1 广告 | 2 分类图标
}, { sequelize, modelName: 'banner' });

// Banner.sync()
//   .then(() => Banner.create({
//     img_url: base_url + 'category/10.png', // 图片路径
//     type: 2,
//   }))
//   .then((result: Banner) => {
//     console.log(result.toJSON());
//   });

export {
  Banner
}