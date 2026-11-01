#build stage: build the ship app
FROM node:20-alpine AS build
#/app is the working directory for the ship app
WORKDIR /app
#alpine linux is a small linux distribution, so we need to install git to clone the ship repo
RUN apk add --no-cache git 
#clone the ship repo from github, but only the latest commit (depth 1) to save time and space
RUN git clone --depth 1 https://github.com/Infratify/ship.git .
#we make a copy of the ship.config.json file from the build context (app/) to the working directory (/app) in the container
COPY ship.config.json ./ship.config.json
#npm ci installs the dependencies listed in package-lock.json, npm test runs the tests, and npm run build builds the app for production
RUN npm ci && npm test && npm run build

#production stage: serve the ship app with nginx and alpine linux
FROM nginx:alpine
#we copy the nginx.conf file from the build context (app/) to the default.conf file in the container's /etc/nginx/conf.d/ directory, which is where nginx looks for its configuration files
COPY nginx.conf /etc/nginx/conf.d/default.conf
#steal the built app from the build stage and copy it to the nginx html directory, which is where nginx serves its static files from
COPY --from=build /app/dist /usr/share/nginx/html
#expose port 80 for the container, which is the default port for HTTP traffic
EXPOSE 80
#CMD specifies the command to run when the container starts, which in this case is to start nginx in the foreground (daemon off) so that the container doesn't exit immediately
CMD ["nginx", "-g", "daemon off;"]
