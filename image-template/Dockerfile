FROM node:24.22.2@sha256:e7add2a490bb17d97b485b8641bd88455fff7839ade0f5eba493c3508124d413

# Create a new user named 'appuser'
RUN useradd -ms /bin/bash appuser

# Set the working directory within the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files from the current directory to the working directory in the container
COPY . .

# Expose the port on which the app runs
EXPOSE 3000

# Set the user to run the container
USER appuser

# Healthcheck instruction to monitor the health of the container
HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1

# Command to run the app when the container starts
CMD ["node", "app.js"]
