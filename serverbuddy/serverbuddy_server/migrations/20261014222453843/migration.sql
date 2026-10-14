BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "agent_sessions" (
    "id" bigserial PRIMARY KEY,
    "agentId" text NOT NULL,
    "channel" text NOT NULL,
    "agentUid" bigint NOT NULL,
    "userKey" text,
    "startedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "agent_session_agent_id_idx" ON "agent_sessions" USING btree ("agentId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "conversation_memories" (
    "id" bigserial PRIMARY KEY,
    "userKey" text NOT NULL,
    "turns" json NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "conversation_memory_user_key_idx" ON "conversation_memories" USING btree ("userKey");


--
-- MIGRATION VERSION FOR serverbuddy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverbuddy', '20261014222453843', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014222453843', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();


COMMIT;
