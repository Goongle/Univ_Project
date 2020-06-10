import pymysql
import csv
import random
conn = pymysql.connect(host = 'localhost', user = 'root', password ='xkdlrj0',db= 'mydb',charset = 'utf8')
curs = conn.cursor()

# Agenda 파일을 긁어 온다. -> 발의자 리스트
# 발의자 리스트와 SQl에서 긁어 온 국회의원과 이름 비교
# Agenda 번호와 국회의원 번호 저장
sql = "select member_of_congress_id,member_of_congress_party from member_of_congress"
curs.execute(sql)
Article_Data = curs.fetchall()


for row in Article_Data :
    temp_Sql = "insert into mva_party_member (Party_Name,Member_ID) values('{}',{})".format(row[1],row[0])
    curs.execute(temp_Sql)

conn.commit()
conn.close()
