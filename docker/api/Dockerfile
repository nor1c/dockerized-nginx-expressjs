FROM node:16

WORKDIR /app

COPY package.json .
COPY tsconfig.json .

RUN npm install

COPY . .

EXPOSE 2021

CMD ["npm", "run", "dev"]