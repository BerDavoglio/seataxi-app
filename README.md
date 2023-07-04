#


## Installation
Use comands in root folder
```bash

npm i

```

## Run
Use comands in root folder for development
```bash

docker-compose up
npm run dev

```
Use comands in root folder for deploy
```bash

docker-compose up
npm run build
npm run serve

```


## Environment variables
Database connection
```bash

DATABASE=
DATABASE_HOST=127.0.0.1
DATABASE_PORT=3306
DATABASE_USERNAME=root
DATABASE_PASSWORD=*

```

## Migrations
To create migration
```bash

npx sequelize migration:create --name=MIGRATION_NAME

```
To make migrations (*SERVER DO IT BY ITSELF WHEN STARTS*)
```bash

npx sequelize db:migrate

```