import jwt from 'jsonwebtoken';
import config from '../config';
import { User } from '../model'

const sign = (id:string) => {
  const token = jwt.sign({ id: String(id) }, config.SECRET);
  return token;
}

const verify = (raw: string) => {
  const userId: any  = jwt.verify(raw, config.SECRET);
  return userId.id;
}

const hasId = async (raw: string) => {
  const id = verify(raw);
  const query = await User.findAll({where: {id}});
  return query.length > 0 ? true : false;
}

export {
  sign,
  verify,
  hasId
}