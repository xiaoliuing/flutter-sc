import express, { Express, Request, Response } from 'express';
const router:Express = express();
import { Data } from '../interfaces/router';
import {categoryList} from '../utils/data';

router.post("/", async (_req: Request,res: Response) => {
    var data: Data = {
        code: 0,
        status: 200,
        message: 'success',
        data: categoryList
    };
    res.send(data);
});

module.exports = router;