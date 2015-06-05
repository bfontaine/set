# Set

Package `set` provides an ultra-simple set implementation in Go.

## Features

* Thread-safe
* `Add`, `Remove`, `Contains`. That’s all.
* Support for `string` and `int`.

## Install

    go get github.com/bfontaine/set

## Usage

    s := set.NewStringSet()
    s.Add("foo")
    s.Add("bar")
    s.Contains("foo") // true
    s.Contains("qux") // false
    s.Remove("foo")
    s.Contains("foo") // false

## Alternatives

* [golang-set](https://github.com/deckarep/golang-set): provides a lot more
  features

## Why didn’t you use golang-set?

Because I needed a really simple `string` set and didn’t care about anything
other than the three operations mentioned above. And golang-set uses
`interface{}`, which was an unnecessary overhead here.
