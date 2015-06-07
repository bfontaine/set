package set

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestIntSetCreate(t *testing.T) {
	is := NewIntSet()
	assert.NotNil(t, is)
}

func TestIntSetAddContains(t *testing.T) {
	is := NewIntSet()
	is.Add(42)
	assert.True(t, is.Contains(42))
}

func TestIntSetRemove(t *testing.T) {
	is := NewIntSet()
	is.Add(42)
	assert.True(t, is.Contains(42))
	is.Remove(42)
	assert.False(t, is.Contains(42))
}
