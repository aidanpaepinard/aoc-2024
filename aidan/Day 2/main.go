package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

const FILE = "input.txt"

type Report struct {
	Levels []int
}

func filter[T interface{}](ss []T, test func(int, T) bool) (ret []T) {
	for i, s := range ss {
		if test(i, s) {
			ret = append(ret, s)
		}
	}
	return
}

// taken from go wiki
func slidingWindow(size int, input []int) [][]int {
	// returns the input slice as the first element
	if len(input) <= size {
		return [][]int{input}
	}

	// allocate slice at the precise size we need
	r := make([][]int, 0, len(input)-size+1)

	for i, j := 0, size; j <= len(input); i, j = i+1, j+1 {
		r = append(r, input[i:j])
	}

	return r
}

func readData() (data []Report) {
	data = make([]Report, 0, 10)
	file, err := os.Open(FILE)
	if err != nil {
		log.Fatalf("failed to read file due to %s", err)
	}
	reader := bufio.NewScanner(file)
	for reader.Scan() {
		line := reader.Text()
		splitStrings := strings.Split(line, " ")
		numbers := make([]int, 0, len(splitStrings))
		for _, string := range splitStrings {
			num, err := strconv.Atoi(strings.TrimSpace(string))
			if err != nil {
				log.Fatalf("failed to parse %s due to %s", string, err)
			}
			numbers = append(numbers, num)
		}
		data = append(data, Report{Levels: numbers})
	}
	return
}

func (r Report) isSafe() bool {
	if len(r.Levels) < 2 {
		log.Fatalf("failed to check report due to not enough data, got %d levels", len(r.Levels))
	}
	// todo: add check for edge case where level[0] == level[1]
	isDecreasing := r.Levels[0] > r.Levels[1]
	for _, window := range slidingWindow(2, r.Levels) {
		if (isDecreasing && !(window[0] > window[1] && window[0]-window[1] <= 3)) ||
			(!isDecreasing && !(window[1] > window[0] && window[1]-window[0] <= 3)) {
			return false
		}
	}

	return true
}

func (r Report) isSafeWithDampener() (safe bool) {
	if len(r.Levels) < 2 {
		log.Fatalf("failed to check report due to not enough data, got %d levels", len(r.Levels))
	}

	if r.isSafe() {
		return true
	}

	for i := 0; i < len(r.Levels); i++ {
		modified := Report{Levels: filter(r.Levels, func(idx int, _ int) bool {
			return i != idx
		})}
		if modified.isSafe() {
			return true
		}
	}

	return false
}

func main() {
	reports := readData()
	safeCount := 0
	safeWithDampenerCount := 0
	for _, report := range reports {
		if report.isSafe() {
			safeCount += 1
		}
		if report.isSafeWithDampener() {
			safeWithDampenerCount += 1
		}
	}
	fmt.Printf("Safe Reports: %d reports.\n", safeCount)
	fmt.Printf("Safe Damped Reports: %d reports.\n", safeWithDampenerCount)
}
