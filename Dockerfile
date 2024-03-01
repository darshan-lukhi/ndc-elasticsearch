FROM golang:1.21-alpine AS build
WORKDIR /app
COPY . .
RUN go mod download
RUN ls
RUN go build -o ./nfc-elasticsearch


FROM scratch
WORKDIR /app
COPY --from=build /app/nfc-elasticsearch ./nfc-elasticsearch

COPY data /data
RUN mkdir -p /etc/connector
ENV HASURA_CONFIGURATION_DIRECTORY=/etc/connector

EXPOSE 8080
ENTRYPOINT ["./ndc-elasticsearch"]
CMD ["serve"]