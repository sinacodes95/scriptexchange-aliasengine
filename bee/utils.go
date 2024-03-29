package main

import (
	"path/filepath"
	"strings"
)

// Max returns the larger of x or y.
func max(x, y int) int {
	if x < y {
		return y
	}
	return x
}

// Min returns the smaller of x or y.
func min(x, y int) int {
	if x > y {
		return y
	}
	return x
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func unique(slice []string) []string {
	keys := make(map[string]bool)
	list := []string{}
	for _, entry := range slice {
		if _, value := keys[entry]; !value {
			keys[entry] = true
			list = append(list, entry)
		}
	}
	return list
}

func uniqueItems(slice []IndexItem) []IndexItem {
	keys := make(map[string]bool)
	list := []IndexItem{}
	for _, entry := range slice {
		if _, value := keys[entry.Name]; !value {
			keys[entry.Name] = true
			list = append(list, entry)
		}
	}
	return list
}

func uniqueSources(slice []SourceFile) []SourceFile {
	keys := make(map[string]bool)
	list := []SourceFile{}
	for _, entry := range slice {
		if _, value := keys[entry.Name]; !value {
			keys[entry.Name] = true
			list = append(list, entry)
		}
	}
	return list
}

func uniquePaths(data []IndexItem) []string {
	var result = []string{}

	for _, item := range data {
		result = append(result, item.Path)
	}

	return unique(result)
}

func filterByPath(data []IndexItem, path string) []IndexItem {
	var result = []IndexItem{}

	for _, item := range data {
		if item.Path == path {
			result = append(result, item)
		}
	}

	return result
}

func fileName(path string) string {
	return filepath.Base(path)
}

func fileNameWithoutExtTrimSuffix(fileName string) string {
	return strings.TrimSuffix(fileName, filepath.Ext(fileName))
}
