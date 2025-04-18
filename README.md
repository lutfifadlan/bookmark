Pre-requisites:
- Install docker on your machine (https://docs.docker.com/get-started/get-docker/)
- Install node on your machine (https://nodejs.org/en/download)
- Install nestjs CLI on your machine: `npm i -g @nestjs/cli`

Important commands:
- Running prisma studio for test db: `npx dotenv -e .env.test -- prisma studio`
- Running app locally: `npm run start:dev`
- Running e2e test: `npm run db:test:restart`