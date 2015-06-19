# Set

[![GoDoc](https://godoc.org/github.com/bfontaine/set?status.svg)](https://godoc.org/github.com/bfontaine/set)
[![Build Status](https://travis-ci.org/bfontaine/set.svg?branch=master)](https://travis-ci.org/bfontaine/set)

Package `set` provides an ultra-simple set implementation in Go.

## Features

* `int` and `string` sets
* Thread-safe
* `Add`, `Remove`, `Contains`, `Size`, `Iterate`. That’s all.

## Install

    go get github.com/bfontaine/set

## Usage

```go
s := set.NewStringSet()
s.Add("foo")
s.Add("bar")
s.Contains("foo") // true
s.Contains("qux") // false
s.Remove("foo")
s.Contains("foo") // false
```

## Alternatives

* [golang-set](https://github.com/deckarep/golang-set): provides a lot more
  features

## FAQ

### Why didn’t you use golang-set?

Because I needed a really simple `string` set and didn’t care about anything
other than the operations mentioned above. And golang-set uses `interface{}`,
which was an unnecessary overhead here.

### Why is there Ruby code here?

Set implementations are the same for all types so I use a small Ruby script and
`go generate` to generate the code for all types at once.
