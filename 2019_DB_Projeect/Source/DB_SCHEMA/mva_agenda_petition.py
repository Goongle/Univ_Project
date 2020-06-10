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
sql = "select Agenda_Title,Agenda_ID from agenda"
curs.execute(sql)
_agenda = curs.fetchall()
agenda_title = []
agenda_id = []

for i in range(0, len(_agenda)):
    agenda_title.append(_agenda[i][0])
    agenda_id.append(_agenda[i][1])

sql = "select Petition_Body,Petition_ID from petition"
curs.execute(sql)
_petition = curs.fetchall()
petition_body = []
petition_id = []

for i in range(0, len(_agenda)):
    petition_body.append(_petition[i][0])
    petition_id.append(_petition[i][1])
'''
for data1 in Article_data :
    for data2 in Agenda_data :
        if (data1[0] in data2[0]) and data1[1] >= 8761 :
            temp_Sql = "insert into mva_agenda_article (Agenda_id ,article_id) values({},{})".format(data2[1],data1[1])
            curs.execute(temp_Sql)
'''

tempList = []
tempTitle = []

for i in range(len(agenda_title)):
    tempList = agenda_title[i].split(" ")
    tempTitle = tempList[0]

    for j in range(len(petition_body)):
        tempBody = petition_body[j]
        if (tempBody.find(tempTitle) != -1):
            sql = "insert mva_agenda_petition (Agenda_ID,Petition_ID) values({},{})".format(agenda_id[i],petition_id[j])
            curs.execute(sql)

conn.commit()
conn.close()
