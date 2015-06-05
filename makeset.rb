#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

if ARGV.length != 1 || ARGV.first.empty? ||  ARGV.first.length < 2
    puts "Usage: #{$0} <type>"
    exit 1
end

template = <<-EOS
package set

import "sync"

// %STRUCT% is a set for elements of type %TYPE%
type %STRUCT% struct {
	content map[%TYPE%]bool
	mu      sync.Mutex
}

// New%STRUCT%Set returns a pointer on a new %STRUCT%
func New%STRUCT%Set() *%STRUCT% {
	return &%STRUCT%{content: make(map[%TYPE%]bool)}
}

// Add adds an element to the set
func (%RECEIVER% *%STRUCT%) Add(%ELEMENT% %TYPE%) {
	%RECEIVER%.mu.Lock()
	defer %RECEIVER%.mu.Unlock()
	%RECEIVER%.content[%ELEMENT%] = true
}

// Remove removes an element from the set
func (%RECEIVER% *%STRUCT%) Remove(%ELEMENT% %TYPE%) {
	%RECEIVER%.mu.Lock()
	defer %RECEIVER%.mu.Unlock()
	delete(%RECEIVER%.content, %ELEMENT%)
}

// Contains tests if a given element is in the set
func (%RECEIVER% *%STRUCT%) Contains(%ELEMENT% %TYPE%) bool {
	%RECEIVER%.mu.Lock()
	defer %RECEIVER%.mu.Unlock()
	_, ok := %RECEIVER%.content[%ELEMENT%]
	return ok
}
EOS

type = ARGV.first
element = type[0]
receiver = "#{element}s"
# note: this won't work with already-capitalized types
struct = type.capitalize

text = template.
    gsub(/%TYPE%/, type).
    gsub(/%ELEMENT%/, element).
    gsub(/%RECEIVER%/, receiver).
    gsub(/%STRUCT%/, struct)

File.open("#{type}_set.go", "w") { |f| f.write(text) }
