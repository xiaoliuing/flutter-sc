import express, { Express, Request, Response, NextFunction } from 'express';
import createError from 'http-errors';
import logger from 'morgan';
import { resolve } from 'path';

const app: Express = express();
logger('dev'); // 打印请求日志
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(resolve(__dirname,"public")));

app.use('/getHomePageContent', require(resolve(__dirname, './routes/home')));
app.use('/getHotGoods', require(resolve(__dirname, './routes/hots')));
app.use('/getCategory', require(resolve(__dirname, './routes/category')));
app.use('/getCategoryGoods', require(resolve(__dirname, './routes/cateGoods')));
app.use('/getGoodDetail', require(resolve(__dirname, './routes/detail_goods')));
app.use('/user', require(resolve(__dirname, './routes/user')));
app.use('/search', require(resolve(__dirname, './routes/search')));

app.use(function (_req, _res, next) {
  next(createError(404));
});

app.use(function (error: any, _req: Request, res: Response, _next: NextFunction) {
  res.status(error.status || 500);
  res.json({
      success: false,
      error
  });
});

export default app;
