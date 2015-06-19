package set

import "sync"

// Int is a set for elements of type int
type Int struct {
	content map[int]bool
	mu      sync.Mutex
}

// NewIntSet returns a pointer on a new IntSet
func NewIntSet() *Int {
	return &Int{content: make(map[int]bool)}
}

// Add adds an element to the set
func (is *Int) Add(i int) {
	is.mu.Lock()
	defer is.mu.Unlock()
	is.content[i] = true
}

// Remove removes an element from the set
func (is *Int) Remove(i int) {
	is.mu.Lock()
	defer is.mu.Unlock()
	delete(is.content, i)
}

// Contains tests if a given element is in the set
func (is *Int) Contains(i int) bool {
	is.mu.Lock()
	defer is.mu.Unlock()
	_, ok := is.content[i]
	return ok
}

// Size returns the number of elements in the set
func (is *Int) Size() int {
	return len(is.content)
}

// Iterate returns a chan to iterate over all values in the set.
func (is *Int) Iterate() chan int {
	c := make(chan int)

	go func() {
		for i := range is.content {
			c <- i
		}
		close(c)
	}()

	return c
}
