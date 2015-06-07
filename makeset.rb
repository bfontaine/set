#! /usr/bin/env ruby
# -*- coding: UTF-8 -*-

if ARGV.length != 1 || ARGV.first.empty? ||  ARGV.first.length < 2
    puts "Usage: #{$0} <type>"
    exit 1
end

source_template = <<-EOS
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

test_template = <<-EOS
package set

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test%STRUCT%SetCreate(t *testing.T) {
	%RECEIVER% := New%STRUCT%Set()
	assert.NotNil(t, %RECEIVER%)
}

func Test%STRUCT%SetAddContains(t *testing.T) {
	%RECEIVER% := New%STRUCT%Set()
	%RECEIVER%.Add(%VAL%)
	assert.True(t, %RECEIVER%.Contains(%VAL%))
}

func Test%STRUCT%SetRemove(t *testing.T) {
	%RECEIVER% := New%STRUCT%Set()
	%RECEIVER%.Add(%VAL%)
	assert.True(t, %RECEIVER%.Contains(%VAL%))
	%RECEIVER%.Remove(%VAL%)
	assert.False(t, %RECEIVER%.Contains(%VAL%))
}
EOS

class Replacer
  def initialize
    @repl = {}
  end

  def replace(**kw)
    kw.each do |k,v|
      @repl["%#{k.to_s.upcase}%"] = v
    end
  end

  def exec(s, output)
    @repl.each { |k,v| s = s.gsub(k, v) }
    File.open(output, "w") { |f| f.write s }
  end
end

r = Replacer.new

type = ARGV.first

val = case type
      when "string"; '"foo"'
      when "int"; "42"
      when "float64"; "3.14"
      end

r.replace :type => type
r.replace :element => type[0]
r.replace :receiver => "#{type[0]}s"
# note: this won't work with already-capitalized types
r.replace :struct => type.capitalize
r.replace :val => val

r.exec source_template, "#{type}_set.go"
r.exec test_template, "#{type}_set_test.go"
