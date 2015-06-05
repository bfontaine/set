package set

import "sync"

type String struct {
	content map[string]bool
	mu      sync.Mutex
}

func NewStringSet() *String {
	return &String{content: make(map[string]bool)}
}

func (ss *String) Add(s string) {
	ss.mu.Lock()
	defer ss.mu.Unlock()
	ss.content[s] = true
}

func (ss *String) Remove(s string) {
	ss.mu.Lock()
	defer ss.mu.Unlock()
	delete(ss.content, s)
}

func (ss *String) Contains(s string) bool {
	ss.mu.Lock()
	defer ss.mu.Unlock()
	_, ok := ss.content[s]
	return ok
}
