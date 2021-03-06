package set

import "sync"

// String is a set for elements of type string
type String struct {
	content map[string]bool
	mu      sync.Mutex
}

// NewStringSet returns a pointer on a new StringSet
func NewStringSet() *String {
	return &String{content: make(map[string]bool)}
}

// Add adds an element to the set
func (ss *String) Add(s string) {
	ss.mu.Lock()
	defer ss.mu.Unlock()
	ss.content[s] = true
}

// Remove removes an element from the set
func (ss *String) Remove(s string) {
	ss.mu.Lock()
	defer ss.mu.Unlock()
	delete(ss.content, s)
}

// Contains tests if a given element is in the set
func (ss *String) Contains(s string) bool {
	ss.mu.Lock()
	defer ss.mu.Unlock()
	_, ok := ss.content[s]
	return ok
}

// Size returns the number of elements in the set
func (ss *String) Size() int {
	return len(ss.content)
}

// Iterate returns a chan to iterate over all values in the set.
func (ss *String) Iterate() chan string {
	c := make(chan string)

	go func() {
		for s := range ss.content {
			c <- s
		}
		close(c)
	}()

	return c
}
