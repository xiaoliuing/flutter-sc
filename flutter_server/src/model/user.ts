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
  paied: DataTypes.STRING
}, { sequelize, modelName: 'user' });

// sequelize.sync()
//   .then(() => User.create({
//     name_id: '15837606535',
//     password: 'e76ted6d76',
//     img: '',
//     nick_name: '',
//     address: '',
//     phone: '15837606535'
//   }))
//   .then((result: User) => {
//     console.log(result.toJSON());
//   });

export {
  User
}