BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "memories" (
    "id" bigserial PRIMARY KEY,
    "author" text NOT NULL,
    "text" text NOT NULL,
    "date" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR serverbuddy
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverbuddy', '20261014213140121', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014213140121', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();


COMMIT;
