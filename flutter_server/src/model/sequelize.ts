import { Sequelize } from 'sequelize';

const sequelize = new Sequelize('shop', 'root', 'lx970112', {
  host: 'localhost',
  dialect: 'mysql',
  logging: true
})

export {
  sequelize
}