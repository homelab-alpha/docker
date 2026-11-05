FROM node:24.4.1@sha256:c7a63f857d6dc9b3780ceb1874544cc22f3e399333c82de2a46de0049e841729

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
