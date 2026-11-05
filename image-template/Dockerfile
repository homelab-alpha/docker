FROM node:24.0.1@sha256:222f704ce7f499c7bd7d101c993b980d86393e87bb54d416bcfcfe8e62aa9f64

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
