📌 What This Module Does

The YouTube Comments module:

Fetches viral / high-engagement YouTube videos

Extracts top-level comments via YouTube Data API v3

Normalizes comments into a structured schema

Upserts comments into PostgreSQL

Prevents duplicates using comment_id

Makes data BI-ready for Power BI / analytics

🧱 Architecture Overview
YouTube Data API
      ↓
n8n Workflow
  ├── Fetch videos
  ├── Fetch comments
  ├── Normalize JSON
  └── Upsert to PostgreSQL
      ↓
PostgreSQL (youtube_comments table)
      ↓
Power BI / Analytics

🔑 YouTube API Configuration (Required)

This module uses the YouTube Data API v3.

API Authentication

Authentication type: API Key

No OAuth

No IP restriction required

Steps

Go to Google Cloud Console

Enable YouTube Data API v3

Create an API Key

(Optional but recommended)
Restrict the key to:

API: YouTube Data API v3

Application: Server / backend

Where the API key is used

In n8n HTTP Request nodes, under query parameter:

key = YOUR_YOUTUBE_API_KEY


⚠️ Do not commit API keys to GitHub
Use n8n credentials or environment variables.

🗄️ Database Setup (PostgreSQL)
Docker (recommended)
docker run -d \
  --name yt-postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=YOUR_PASSWORD \
  -e POSTGRES_DB=postgres \
  -p 5433:5432 \
  postgres:15

pgAdmin (optional UI)
docker run -d \
  --name pgadmin \
  -p 5050:80 \
  -e PGADMIN_DEFAULT_EMAIL=admin@admin.com \
  -e PGADMIN_DEFAULT_PASSWORD=admin123 \
  dpage/pgadmin4


Access pgAdmin at:
👉 http://localhost:5050

🧾 Database Schema

Create the table once:

CREATE TABLE youtube_comments (
  id BIGSERIAL PRIMARY KEY,
  comment_id TEXT UNIQUE,
  video_id TEXT NOT NULL,
  text TEXT NOT NULL,
  author TEXT,
  likes INTEGER,
  published_at TIMESTAMPTZ,
  region TEXT,
  source TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);


comment_id is used for deduplication (upsert key)

🔄 n8n Workflow Setup
Required Nodes

HTTP Request — Video Fetch

Code (JavaScript) — Extract video IDs

HTTP Request — Comments Fetch

Code (JavaScript) — Normalize comments

Postgres — Insert or Update rows

Postgres Node Configuration (Important)

Operation: Insert or Update

Schema: public

Table: youtube_comments

Mapping Mode: ✅ Map Automatically

Match column: comment_id

Why automatic mapping?

Ensures JSON fields align exactly with table columns and avoids expression leaks.

📊 Power BI Integration

This module is designed to work directly with Power BI.

Connection

Host: localhost

Port: 5433

Database: postgres

User: postgres

Mode: Import (recommended)

Suggested Analytics

Most commented videos

Most liked comments per video

Comment volume over time

Keyword / sentiment analysis (via Power BI or downstream NLP)

🧠 Design Decisions

Postgres instead of Sheets → scalability

Upsert by comment_id → idempotent runs

No IP-locked auth → simpler CI/CD

BI-ready schema → zero transformation in Power BI

⚠️ Notes & Gotchas

Running the workflow multiple times will not duplicate comments

YouTube API has quota limits — batch responsibly

Only top-level comments are ingested (no replies by default)

🧩 Files Related to This Module
sql/
 └── 001_create_youtube_comments.sql

*.json
 └── n8n workflow exports (YouTube ingestion)