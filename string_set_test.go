package set

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestStringSetCreate(t *testing.T) {
	ss := NewStringSet()
	assert.NotNil(t, ss)
}

func TestStringSetAddContains(t *testing.T) {
	ss := NewStringSet()
	ss.Add("foo")
	assert.True(t, ss.Contains("foo"))
}

func TestStringSetRemove(t *testing.T) {
	ss := NewStringSet()
	ss.Add("foo")
	assert.True(t, ss.Contains("foo"))
	ss.Remove("foo")
	assert.False(t, ss.Contains("foo"))
}
