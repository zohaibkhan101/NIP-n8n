# NIP-n8n
# NIP-n8n
## To Create Postgres Image in Docker 
sudo docker run -it --name postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=123456 -e POSTGRES_DB=postgres -v pgdata:/var/lib/postgresql -p 5433:5432 --network bridge postgres 
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
CREATE TABLE reddit_posts (
    id SERIAL PRIMARY KEY,
    hash VARCHAR(50) UNIQUE,
    title TEXT NOT NULL,
    subreddit VARCHAR(100),
    upvotes INTEGER,
    comments INTEGER,
    url TEXT,
    timestamp TIMESTAMPTZ
);

CREATE TABLE twitter_tweets (
    id BIGSERIAL PRIMARY KEY,

    tweet_id VARCHAR(64) UNIQUE NOT NULL,
    tweet_text TEXT NOT NULL,

    author_id VARCHAR(64),
    author_username VARCHAR(100),
    author_name VARCHAR(150),

    created_at TIMESTAMPTZ,
    language VARCHAR(10),

    like_count INT DEFAULT 0,
    retweet_count INT DEFAULT 0,
    reply_count INT DEFAULT 0,
    quote_count INT DEFAULT 0,

    query_keyword TEXT,            -- e.g. "Pakistan Army"
    query_type VARCHAR(50),         -- latest / top / etc
    source VARCHAR(50) DEFAULT 'twitterapi',

    sentiment_score REAL,           -- optional (-1 to 1)
    sentiment_label VARCHAR(20),    -- positive / neutral / negative

    raw_payload JSONB,              -- full API response (for safety)

    inserted_at TIMESTAMPTZ DEFAULT now()
);


## To install pgadmin4
docker pull dpage/pgadmin4

docker run -d \
  -p 5050:80 \
  -e PGADMIN_DEFAULT_EMAIL="admin@local" \
  -e PGADMIN_DEFAULT_PASSWORD="YourSecurePwd" \
  dpage/pgadmin4

## Metabase Open Source quick start
Use this quick start to run the Open Source version of Metabase locally. See below for instructions on running Metabase in production.

Assuming you have Docker installed and running, get the latest Docker image:

docker pull metabase/metabase:latest

    
Then start the Metabase container:

docker run -d -p 3000:3000 --name metabase metabase/metabase
    
Copy

    
This will launch an Metabase server on port 3000 by default.

Optional: to view the logs as your Open Source Metabase initializes, run:

docker logs -f metabase
    
Copy

    
Once startup completes, you can access your Open Source Metabase at http://localhost:3000.
