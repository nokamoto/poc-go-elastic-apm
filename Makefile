all:
	(cd protobuf && make)
	gofmt -d .
	gofmt -w .
	go build
	docker-compose down
	docker-compose build
