import { Model, DataTypes } from 'sequelize';
import { sequelize } from './sequelize';
class Tag extends Model{}

Tag.init({
  type: DataTypes.STRING,
  data: DataTypes.STRING,
}, { sequelize, modelName: 'tag' });

export {
  Tag
}