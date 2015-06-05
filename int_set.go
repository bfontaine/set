package set

import "sync"

type Int struct {
	content map[int]bool
	mu      sync.Mutex
}

func NewIntSet() *Int {
	return &Int{content: make(map[int]bool)}
}

func (is *Int) Add(i int) {
	is.mu.Lock()
	defer is.mu.Unlock()
	is.content[i] = true
}

func (is *Int) Remove(i int) {
	is.mu.Lock()
	defer is.mu.Unlock()
	delete(is.content, i)
}

func (is *Int) Contains(i int) bool {
	is.mu.Lock()
	defer is.mu.Unlock()
	_, ok := is.content[i]
	return ok
}
