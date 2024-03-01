FROM golang:1.21-alpine AS build
WORKDIR /app
COPY . .
RUN go mod tidy
RUN go build -o ndc-elasticsearch
RUN mkdir -p /etc/connector

FROM scratch
WORKDIR /app
COPY --from=build /app/ndc-elasticsearch ./ndc-elasticsearch
COPY --from=build /etc/connector /etc/connector
COPY data /data


ENV HASURA_CONFIGURATION_DIRECTORY=/etc/connector

EXPOSE 8080
ENTRYPOINT ["./ndc-elasticsearch"]
CMD ["serve"]