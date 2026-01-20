-- YouTube comments ingestion table
-- Source: YouTube Data API v3

CREATE TABLE IF NOT EXISTS youtube_comments (
  id BIGSERIAL PRIMARY KEY,
  comment_id TEXT UNIQUE NOT NULL,
  video_id TEXT NOT NULL,
  text TEXT NOT NULL,
  author TEXT,
  likes INTEGER DEFAULT 0,
  published_at TIMESTAMPTZ,
  region TEXT,
  source TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_youtube_comments_video_id
  ON youtube_comments(video_id);

CREATE INDEX IF NOT EXISTS idx_youtube_comments_published_at
  ON youtube_comments(published_at);
