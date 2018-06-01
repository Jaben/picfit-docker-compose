# picfit-docker-compose
Build and Run Dockerfile for [Picfit Image Server](https://github.com/thoas/picfit)

## Build

```
docker image build --tag picfit:v1 .
```

## Configure

Configure the picfit instance by modifying the `./picfit-config/config.json` file.

## Run

Run using docker-compose.

```
docker-compose up -d
```