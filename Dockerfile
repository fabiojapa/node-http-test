FROM node:14.15-alpine

WORKDIR /app
ENV NODE_PATH=.

COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "/app/"]
COPY ["./", "/app/"]

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 /usr/local/bin/dumb-init

RUN npm install && chmod +x /usr/local/bin/dumb-init

EXPOSE 3000

CMD ["dumb-init", "npm", "run", "start"]
