CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" INTEGER PRIMARY KEY, "inserted_at" TEXT);
CREATE TABLE IF NOT EXISTS "seats" ("id" INTEGER PRIMARY KEY AUTOINCREMENT, "seat_id" TEXT NOT NULL, "is_booked" INTEGER DEFAULT false, "phone_number" TEXT, "full_name" TEXT, "inserted_at" TEXT NOT NULL, "updated_at" TEXT NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
INSERT INTO schema_migrations VALUES(20231121175409,'2023-11-21T17:58:01');
