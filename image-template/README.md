# My Docker Webserver Project Template

This project contains a simple web server running in a Docker container using
Node.js, Express, and Docker Compose.

## Requirements

- Docker: [Installation Guide](https://docs.docker.com/get-docker/)
- Docker Compose: [Installation Guide](https://docs.docker.com/compose/install/)

## Installation and Usage

1. **Clone the repository:**

   ```bash
   git clone https://github.com/homelab-alpha/docker/.git
   ```

2. **Navigate to the project directory:**

   ```bash
   cd image-template
   ```

3. **Build the Docker image:**

   ```bash
   docker build -t image-template .
   ```

4. **Start the containers using Docker Compose:**

   ```bash
   docker-compose up
   ```

5. **Open your web browser and go to
   [http://localhost:3000](http://localhost:3000) to view the web server.**

## Custom Configuration

- **Changing port:** If you want to change the web server port, modify the port
  in the `docker-compose.yml` file under `ports`.

- **Customizing the application:** You can customize the Node.js application in
  the `app.js` file to fit your needs. Make sure to save any changes and rebuild
  the Docker image.

## Contribution

Contributions to this repository are welcome! If you have a shell script that
you believe would be valuable to others, feel free to open a pull request. Pleas
make sure your script is well documented and follows best practices. Read more
about
[contributing to this project](https://github.com/homelab-alpha/docker/blob/main/CONTRIBUTING.md)
for more information.

## License

This project is licensed under the MIT License - see the
[LICENSE](https://github.com/homelab-alpha/docker/blob/main/LICENSE.md) file for
details.

## Contact

If you have any questions, suggestions, or issues, please feel free to open an
[issue] or [pull request].

[issue]: https://github.com/homelab-alpha/docker/issues/new
[pull request]: https://github.com/homelab-alpha/docker/pulls
