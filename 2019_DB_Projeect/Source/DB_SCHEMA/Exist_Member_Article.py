import pymysql
import csv
import random
conn = pymysql.connect(host = 'localhost', user = 'root', password ='xkdlrj0',db= 'mydb',charset = 'utf8')
curs = conn.cursor()
# 키워드랑 기사 번호 추출 하기
# 이름이랑 번호 비교하기
# 국회의원이랑 기사 비교 후 넣기
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
sql = "select Article_ID,Article_keyword from article"
curs.execute(sql)
Article_data = curs.fetchall() ## Article_ID, Article_Keyword 순서

sql = "select member_of_congress_id,Member_of_congress_name from member_of_congress"
curs.execute(sql)
Member_data = curs.fetchall()


for data1 in Article_data :
    for data2 in Member_data :
        if (data1[1] == data2[1]) :
            temp_Sql = "insert into exist_member_article (member_id,article_id) values({},{})".format(data2[0],data1[0])
            curs.execute(temp_Sql)

conn.commit()
conn.close()
