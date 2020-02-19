import app from '../app';
import http from 'http';
import config from '../config/index';

const { HOST, PORT } = config;

const server = http.createServer(app);

server.listen(PORT);
server.on('error', onError);
server.on('listening', onListening);
function onError(error: any) {
  console.error(error);
}
function onListening() {
  console.log(`>>>>>Listening on ${HOST}:${PORT}....`);
}