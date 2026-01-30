package main

import "testing"

func TestExample(t *testing.T) {
    expected := "Go with Make"
    // This is a dummy test that always passes
    if expected != "Go with Make" {
        t.Errorf("Expected %s, but got something else", expected)
    }
}

