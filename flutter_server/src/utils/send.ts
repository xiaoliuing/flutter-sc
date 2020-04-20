import { Data } from '../interfaces/router';

export const send = (res: any, data: object, code: number = 0, status: number = 200) => {
  const _data: Data = {
    code,
    status,
    message: code === 0 ? 'success' : 'fail',
    data
  }
  res.send(_data);
}