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

HEALTHCHECK --interval=1m --timeout=30s --retries=3 CMD curl --fail http://localhost:8080 || exit 1

CMD ["npm", "run", "serve"]