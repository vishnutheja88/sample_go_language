package main

import (
	"fmt"
	"net/http"
)

var Version = "v0.1.0"

func main() {
	// Printf (Print Formatted) is required for %s
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello from Go behind Envoy! Version: %s\n", Version)
	})
	fmt.Printf("Server starting on :9090..")
	http.ListenAndServe(":9090", nil)
}
