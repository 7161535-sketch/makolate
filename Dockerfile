FROM node:24-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY src ./src
COPY public ./public
COPY scripts ./scripts
COPY agent ./agent

# DATA_DIR חייב להצביע על אחסון קבוע, אחרת הנתונים נמחקים בכל דיפלוי
ENV NODE_ENV=production \
    PORT=3000 \
    DATA_DIR=/data \
    BEHIND_PROXY=1

VOLUME ["/data"]
EXPOSE 3000

CMD ["node", "src/server.js"]
