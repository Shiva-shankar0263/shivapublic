# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/shivapublic/sdk:3.1-apline AS build-env

RUN apk --no-cache upgrade musl

WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN shivapublic restore

# Copy everything else and build
COPY .  ./
RUN shivapublic publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/shivapublic/aspnet:3.1-alpine

RUN apk --no-cache upgrade musl

WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["shivapublic", "panz.dll"]
