import { Model, DataTypes } from 'sequelize';
import { sequelize } from './sequelize';
class User extends Model{}

User.init({
  name_id: DataTypes.STRING,
  password: DataTypes.STRING,
  img: DataTypes.STRING,
  nick_name: DataTypes.STRING,
  address: DataTypes.STRING,
  phone: DataTypes.STRING,
  cart: DataTypes.STRING,
  paied: DataTypes.STRING,
  received: DataTypes.STRING,
}, { sequelize, modelName: 'user' });

export {
  User
}