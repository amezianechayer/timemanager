FROM node:20-alpine

WORKDIR /frontend

COPY package*.json ./

RUN apk add --no-cache git

RUN npm install npm@latest -g
RUN npm install npm@latest -g


# RUN npm ci --only=production
# RUN npm install --production
RUN npm install

COPY . .

EXPOSE 8080

CMD ["npm", "run", "serve"]