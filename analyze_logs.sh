#!/bin/bash
awk 'END {print "Отчет о логе веб-сервера"}' access.log > report.txt
awk 'BEGIN { for (i = 1; i <= 24; i++) printf("="); print "" }' access.log >> report.txt

# Подсчитать общее количество запросов.
awk 'END {print "Общее количество запросов:\t" NR}' access.log >> report.txt

# Подсчитать количество уникальных IP-адресов. Строго с использованием awk.
awk '{ ip[$1]++ } END {print "Количество уникальных IP-адресов:\t"  length(ip) }' access.log  >> report.txt

#Подсчитать количество запросов по методам (GET, POST и т.д.). Строго с использованием awk.
awk 'END {print "\n""Количество запросов по методам:"}' access.log >> report.txt
awk '/GET/ {get_count++} END {if (get_count > 0) print "   "get_count " GET" }' access.log >> report.txt
awk '/POST/ {post_count++} END {if (post_count > 0) print "   "post_count " POST" }' access.log >> report.txt
awk '/PUT/ {put_count++} END  {if (put_count > 0) print "   "put_count " PUT" }' access.log >> report.txt
awk '/DELETE/ {del_count++} END {if (del_count > 0 ) print "   "del_count " DELETE" }' access.log >> report.txt

#Найти самый популярный URL. Строго с использованием awk.
awk '
{ count[$7]++ } END { for (i in count){
			if (count[i]>max){
				 max=count[i]
				 max_url=i }}
print "\n""Самый популярный URL:\t" max max_url
}' access.log >> report.txt
echo "Отчет сохранен в файл report.txt"



