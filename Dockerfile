FROM node:16

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --omit=dev

COPY . .

RUN adduser -u 1001 -D appuser && chown -R appuser /usr/src/app

USER appuser

EXPOSE 3000

CMD [ "node", "index.js" ]
