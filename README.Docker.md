### Building and running your application

When you're ready, start your application by running:
`docker compose up --build`.

Your application will be available at http://localhost:5000.

For background (detached) runs:

```bash
docker compose up -d --build
```

If you prefer to run a single image directly:

```bash
docker build -t flaskwebsync .
docker run --rm -p 5000:5000 flaskwebsync
```

### Deploying your application to the cloud

First, build your image, e.g.: `docker build -t flaskwebsync .`.
If your cloud uses a different CPU architecture than your development
machine (e.g., you are on a Mac M1 and your cloud provider is amd64),
you'll want to build the image for that platform, e.g.:
`docker build --platform=linux/amd64 -t flaskwebsync .`.

Then, push it to your registry, e.g. `docker push myregistry.com/flaskwebsync`.

Consult Docker's [getting started](https://docs.docker.com/go/get-started-sharing/)
docs for more detail on building and pushing.

### Environment / secrets

- For local development use an `.env` file and add `env_file: .env` to your
	`docker-compose` service. Never commit secrets (API keys, DB passwords,
	private tokens) to the repository.

- Example `.env` entry:

```text
FLASK_ENV=production
SECRET_KEY=replace_this_with_a_secure_value
# DATABASE_URL=postgresql://user:password@db:5432/dbname
```

### Troubleshooting

- View container logs:

```bash
docker compose logs -f server
```

- Inspect running containers and health status:

```bash
docker compose ps
docker inspect --format='{{json .State}}' <container-id>
```

- If the container fails to start, try building with `--no-cache` to ensure a
	clean rebuild:

```bash
docker build --no-cache -t flaskwebsync .
```

### References
* [Docker's Python guide](https://docs.docker.com/language/python/)