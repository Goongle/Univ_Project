import pymysql
import csv
import random
conn = pymysql.connect(host = 'localhost', user = 'root', password ='xkdlrj0',db= 'mydb',charset = 'utf8')
curs = conn.cursor()


Member_list = [] ## 이름 지역 소속당
Member_read = open('congress_member_result.csv','r')
Member_reader = csv.reader(Member_read)
for var in Member_reader:
    if(var[0] == '\n'):
        continue
    var[2] = var[2].encode("UTF-8")
    var[2] = var[2].decode("UTF-8")
    Member_list.append(var)
Member_read.close()

i = 1
for row in Member_list :
    sql = "insert into member_of_congress (Member_of_Congress_ID,Member_of_Congress_Name,Member_of_Congress_region,member_of_congress_party) values({},'{}','{}','{}')".format(i,row[0],row[1],row[2])
    print(sql)
    i+= 1
    curs.execute(sql)

for row in Member_list :
    sql = "update member_of_congress set member_of_congress_party = '{}' where Member_of_Congress_name = '{}'".format(row[2],row[0])
    curs.execute(sql)
conn.commit()
conn.close()
