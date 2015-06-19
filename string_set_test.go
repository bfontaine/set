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

func TestStringSetSize(t *testing.T) {
	ss := NewStringSet()
	assert.Equal(t, 0, ss.Size())
	ss.Add("foo")
	assert.Equal(t, 1, ss.Size())
}

func TestStringSetIterate(t *testing.T) {
	ss := NewStringSet()
	ss.Add("foo")
	for x := range ss.Iterate() {
		assert.Equal(t, "foo", x)
	}
}
