#build stage
FROM node:alpine AS build
WORKDIR .
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

#prod stage
FROM node:alpine
WORKDIR .
ENV ENVIRONMENT=production
COPY --from=build ./dist/ ./dist
COPY package*.json ./
RUN npm install --only=production --omit=dev
RUN rm package*.json
EXPOSE 5000

CMD ["node", "dist/main.js"]
