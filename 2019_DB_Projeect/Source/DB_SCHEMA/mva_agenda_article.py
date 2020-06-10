import pymysql
import csv
import random
conn = pymysql.connect(host = 'localhost', user = 'root', password ='xkdlrj0',db= 'mydb',charset = 'utf8')
curs = conn.cursor()
# Article 키워드와 Number 추출
# Agenda Title과 Number 추출
# Agenda Title과 비교 연산을 통해 Number 값 넣기
'''
agenda_list = [] ## 날짜, 제목, 내용, 발의자
agenda_read = open('pro_result.csv', 'r')
agenda_reader = csv.reader(agenda_read)
ind_number = 0
for row in agenda_reader:
    if (row[0] == '\n'):
        continue
    agenda_list.append(row)
agenda_read.close()

for row in agenda_list :
    sql = "insert into agenda (Agenda_ID,Agenda_Date,Agenda_Title,Agenda_Body) values(0,'{}','{}','{}')".format(row[0],row[1],row[2])
    ind_number+= 1
    curs.execute(sql)
conn.commit()
conn.close()
'''
sql = "select article_keyword,Article_ID from article"
curs.execute(sql)
Article_data = curs.fetchall() ## Article_Keyword,  Article_ID 순서

sql = "select agenda_title,agenda_id from agenda"
curs.execute(sql)
Agenda_data = curs.fetchall() #3 Agenda_title, Agenda_ID 순서


for data1 in Article_data :
    for data2 in Agenda_data :
        if (data1[0] in data2[0]) and data1[1] >= 8761 :
            temp_Sql = "insert into mva_agenda_article (Agenda_id ,article_id) values({},{})".format(data2[1],data1[1])
            curs.execute(temp_Sql)

conn.commit()
conn.close()
