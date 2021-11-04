# PBL_MATTHEW

## Setup

### Env variables

If you don't have `.env` file then run

```
cp .env.sample .env
```

and set your env variables if any.

### Build and start Docker containers

Run

```
docker-compose build
docker-compose up
docker-compose run web rails db:create
docker-compose run web rails db:migrate
docker-compose restart web
```

## Start server

Run

```
docker-compose up
```

If you don't want to enable pgadmin run:
```
docker-compose up web
```

then access `http://localhost:3000`.
