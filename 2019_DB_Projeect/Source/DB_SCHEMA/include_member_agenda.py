import pymysql
import csv
import random
conn = pymysql.connect(host = 'localhost', user = 'root', password ='xkdlrj0',db= 'mydb',charset = 'utf8')
curs = conn.cursor()

# Agenda 파일을 긁어 온다. -> 발의자 리스트
# 발의자 리스트와 SQl에서 긁어 온 국회의원과 이름 비교
# Agenda 번호와 국회의원 번호 저장

agenda_list = [] ## 날짜, 제목, 내용, 발의자
agenda_read = open('pro_resultsFinal.csv', 'r')
agenda_reader = csv.reader(agenda_read)
agenda_number = 1
agenda_memberList = []


for row in agenda_reader:
    if (row[0] == '\n'):
        continue
    row.insert(0, agenda_number)
    temp = row[4]
    temp = temp[1:-1]
    temp = temp.replace("'","")
    agenda_memberList = temp.split(',')

    del row[-1]
    row.append(agenda_memberList)
    agenda_list.append(row)
    agenda_number+= 1

print(agenda_list[0][4])
print(type(agenda_list[0][4]))
sql = "select member_of_congress_id,Member_of_congress_name from member_of_congress"
curs.execute(sql)
Member_data = curs.fetchall()


for data1 in agenda_list :
    for data2 in data1[4] :
        for data3 in Member_data :
            if (data2 == data3[1]) :
                temp_Sql = "insert into include_member_agenda_ (member_id,agenda_id) values({},{})".format(data3[0],data1[0])
                curs.execute(temp_Sql)

conn.commit()
conn.close()
