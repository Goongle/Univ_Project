import pymysql
import csv
import random
conn = pymysql.connect(host = 'localhost', user = 'root', password ='xkdlrj0',db= 'mydb',charset = 'utf8')

curs = conn.cursor()

agenda_list = [] ## 날짜, 제목, 내용, 발의자
agenda_read = open('pro_resultsFinal.csv', 'r')
agenda_reader = csv.reader(agenda_read)
for row in agenda_reader:
    if (row[0] == '\n'):
        continue
    agenda_list.append(row)
agenda_read.close()
random_list = ['경제','국방','문화','사회','연예','외교','정치']
agenda_number = 1
for row in agenda_list :
    random_number = random.randrange(0,7)
    sql = "insert into agenda (Agenda_ID,Agenda_Date,Agenda_Title,Agenda_Body,Agenda_Domain) values({},'{}','{}','{}','{}')".format(agenda_number,row[0],row[1],row[2],random_list[random_number])
    agenda_number+= 1
    curs.execute(sql)

conn.commit()
conn.close()
