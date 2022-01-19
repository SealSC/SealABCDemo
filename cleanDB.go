package main

import (
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
	"fmt"
	"regexp"
	"io/ioutil"
	"os"
	"path"
)

func main() {
	sprintf := fmt.Sprintf("%s:%s@tcp(127.0.0.1:%d)/?charset=utf8mb4&collation=utf8mb4_bin&loc=Local&parseTime=true", "root", "123456789", 3306)
	DB, err := gorm.Open("mysql", sprintf)
	if err != nil {
		panic(err)
	}
	CleanDatabase(DB, "0x0")
	CleanDatabase(DB, "0x1")
	CleanDatabase(DB, "0x2")
	CleanDatabase(DB, "0x3")
	CleanDatabase(DB, "0x4")
	deleteFile("/Users/ltt/ltto/gocode/SealABC", "/Users/ltt/ltto/gocode/SealABC/localPlay")
}
func deleteFile(dirs ...string) {
	compile, err := regexp.Compile("cache\\..*\\.db")
	if err != nil {
		panic(err)
	}
	for _, dir := range dirs {
		readDir, err := ioutil.ReadDir(dir)
		if err != nil {
			panic(err)
		}
		for _, info := range readDir {
			name := info.Name()
			if info.IsDir() && compile.MatchString(name) {
				err := os.RemoveAll(path.Join(dir, info.Name()))
				if err != nil {
					panic(err)
				}
			}
		}
	}
}

func tables(DB *gorm.DB, database string) (tabs []string) {
	err := DB.Exec(fmt.Sprintf("USE `%s`", database)).Error
	if err != nil {
		panic(err)
	}
	rows, err := DB.Raw("SHOW TABLES;").Rows()
	if err != nil {
		panic(err)
	}
	for rows.Next() {
		var temp string
		err := rows.Scan(&temp)
		if err != nil {
			panic(err)
		}
		tabs = append(tabs, temp)
	}
	return
}
func CleanDatabase(DB *gorm.DB, database string) {
	tabs := tables(DB, database)
	for _, tab := range tabs {
		err := DB.Exec(fmt.Sprintf("DELETE FROM `%s`", tab)).Error
		if err != nil {
			panic(err)
		}
	}
}
