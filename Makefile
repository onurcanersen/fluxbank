postgres:
	docker run --name fluxbank_db -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

create-db:
	docker exec -it fluxbank_db createdb --username=root --owner=root fluxbank_db

drop-db:
	docker exec -it fluxbank_db dropdb fluxbank_db

migrate-up:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/fluxbank_db?sslmode=disable" -verbose up

migrate-down:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/fluxbank_db?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres create-db drop-db  migrate-up migrate-down sqlc
