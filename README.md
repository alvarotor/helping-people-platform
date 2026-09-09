# HelpingPeopleNow Platform

Local Compose platform for the application repository at `../helping-people`.

## Start locally

```bash
cp .env.example .env
docker compose config
docker compose up --build
```

Open <http://localhost:8080>. The gateway routes public web traffic, admin traffic under `/admin/`, application API traffic under `/api/`, and auth traffic under `/api/auth/`.

Stop the stack with `docker compose down`. Add `-v` only when intentionally deleting the local PostgreSQL volume.

This is a development scaffold. Production secrets, TLS, backups, deployment promotion, and cloud resources are separate follow-up changes.
