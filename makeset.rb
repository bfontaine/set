#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

template = <<-EOS
package set

import "sync"

type %STRUCT% struct {
	content map[%TYPE%]bool
	mu      sync.Mutex
}

func New%STRUCT%Set() *%STRUCT% {
	return &%STRUCT%{content: make(map[%TYPE%]bool)}
}

func (%RECEIVER% *%STRUCT%) Add(%ELEMENT% %TYPE%) {
	%RECEIVER%.mu.Lock()
	defer %RECEIVER%.mu.Unlock()
	%RECEIVER%.content[%ELEMENT%] = true
}

func (%RECEIVER% *%STRUCT%) Remove(%ELEMENT% %TYPE%) {
	%RECEIVER%.mu.Lock()
	defer %RECEIVER%.mu.Unlock()
	delete(%RECEIVER%.content, %ELEMENT%)
}

func (%RECEIVER% *%STRUCT%) Contains(%ELEMENT% %TYPE%) bool {
	%RECEIVER%.mu.Lock()
	defer %RECEIVER%.mu.Unlock()
	_, ok := %RECEIVER%.content[%ELEMENT%]
	return ok
}
EOS

if ARGV.length != 1 || ARGV.first.empty? ||  ARGV.first.length < 2
    puts "Usage: #{$0} <type>"
    exit 1
end

type = ARGV.first
element = type[0]
receiver = "#{element}s"
struct = type.capitalize

text = template.
    gsub(/%TYPE%/, type).
    gsub(/%ELEMENT%/, element).
    gsub(/%RECEIVER%/, receiver).
    gsub(/%STRUCT%/, struct)

File.open("#{type}_set.go", "w") { |f| f.write(text) }
