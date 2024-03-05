package main

import (
	"github.com/darshan-lukhi/ndc-elasticsearch/types"
	"github.com/hasura/ndc-sdk-go/connector"
)

func main() {
	if err := connector.Start[types.Configuration, types.State](
		&Connector{},
		connector.WithMetricsPrefix("ndc-elasticsearch"),
		connector.WithDefaultServiceName("ndc-elasticsearch"),
	); err != nil {
		panic(err)
	}
}
