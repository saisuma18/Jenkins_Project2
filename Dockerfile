FROM  node:16-alpine
WORKDIR /the/workdir/path
COPY package*.json ./
RUN apk add --no-cache git
COPY source destopy ..
CMD [ "node" ]