# YouTube Comments Ingestion Module (NIP)

A MVP for **n8n module** that fetches YouTube comments using the **YouTube Data API v3**, normalizes them, and upserts them into **PostgreSQL** for analytics and BI tools like **Power BI**.

---

## What This Module Does

- Fetches **viral / high‑engagement YouTube videos**
- Extracts **top‑level comments** via YouTube Data API v3
- Normalizes comments into a **structured schema**
- **Upserts** data into PostgreSQL (no duplicates)
- Makes comments **BI‑ready** for Power BI / analytics
- Designed to plug into the **NIP (Network Intelligence Platform)**

---

## Architecture Overview

```
YouTube Data API v3
        |
        v
n8n Workflow
  ├─ Fetch Videos
  ├─ Fetch Comments
  ├─ Normalize JSON
  └─ Upsert to PostgreSQL
        |
        v
PostgreSQL (youtube_comments)
        |
        v
Power BI / Analytics
```

---

## Folder Structure

```
modules/
└── youtube-comments/
    ├── README.md
    ├── workflow/
    │   └── youtube_comments_ingestion.json
    ├── sql/
    │   └── 001_create_youtube_comments.sql
```

> Everything related to this module lives **inside one folder**.

---

## PostgreSQL Schema

Table: `public.youtube_comments`

| Column        | Type          | Description |
|--------------|---------------|-------------|
| id           | BIGSERIAL PK  | Internal ID |
| comment_id   | TEXT UNIQUE   | YouTube comment ID |
| video_id     | TEXT          | YouTube video ID |
| text         | TEXT          | Comment text |
| author       | TEXT          | Comment author |
| likes        | INT           | Like count |
| published_at | TIMESTAMPTZ   | Comment publish time |
| region       | TEXT          | Region (e.g. PK) |
| source       | TEXT          | youtube_api |
| created_at   | TIMESTAMPTZ   | Insert timestamp |

---

## Database Setup (Docker)

```bash
docker run -d   --name yt-postgres   -e POSTGRES_PASSWORD=postgres   -p 5433:5432   postgres:15
```

Optional pgAdmin:

```bash
docker run -d   --name pgadmin   -p 5050:80   -e PGADMIN_DEFAULT_EMAIL=admin@admin.com   -e PGADMIN_DEFAULT_PASSWORD=admin123   dpage/pgadmin4
```

---

## n8n Workflow

### Import Workflow

1. Open n8n
2. Click **Import workflow**
3. Select:
```
modules/youtube-comments/workflow/youtube_comments_ingestion.json
```
4. Save

---

## YouTube API Configuration

This module uses **YouTube Data API v3**

- **Auth type:** API Key
- **No OAuth**
- **No IP restriction**
- Created via **Google Cloud Console**

Add the API key in the HTTP Request nodes.

---

## PostgreSQL Credentials (n8n)

| Field | Value |
|------|------|
| Host | `host.docker.internal` |
| Port | `5433` |
| Database | `postgres` |
| User | `postgres` |
| SSL | Disabled |

---

## Power BI Integration

1. Open **Power BI Desktop**
2. Get Data → **PostgreSQL**
3. Server:
```
localhost
```
4. Database:
```
postgres
```
5. Select table:
```
public.youtube_comments
```
6. Use **Import mode**

You can now analyze:
- Most commented videos
- Comment trends by date
- Engagement by author
- Keyword patterns

---
<<<<<<< HEAD



=======
>>>>>>> 4b905a1 (Update README.md)
