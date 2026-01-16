# NIP-n8n
# NIP-n8n
## To Create Postgres Image in Docker 
sudo docker run -it --name postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=123456 \
  -e POSTGRES_DB=postgres \
  --network bridge \
  postgres
## TO create table in db:
CREATE TABLE news_items (
    id BIGSERIAL PRIMARY KEY,
    source VARCHAR(50) NOT NULL,
    origin TEXT,
    raw_text TEXT NOT NULL,
    published_at TIMESTAMPTZ NOT NULL,
    url TEXT NOT NULL,
    content_length INTEGER,
    hash CHAR(64) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
## To install pgadmin4
docker pull dpage/pgadmin4

docker run -d \
  -p 5050:80 \
  -e PGADMIN_DEFAULT_EMAIL="admin@local" \
  -e PGADMIN_DEFAULT_PASSWORD="YourSecurePwd" \
  dpage/pgadmin4

