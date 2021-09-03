FROM node:10-alpine

COPY ./ /app
WORKDIR /app/user-list-front

RUN npm ci
RUN npm run build:mac

WORKDIR /app/user-list-back

RUN npm ci
RUN npm run build

EXPOSE 3000

CMD npm run start:prod

