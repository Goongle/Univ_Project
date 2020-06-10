import pymysql
import csv
import random
conn = pymysql.connect(host = 'localhost', user = 'root', password ='xkdlrj0',db= 'mydb',charset = 'utf8')
curs = conn.cursor()

pet_list = []
pet_read = open('pet_result_real.txt','r')
pet_reader = csv.reader(pet_read)
for var in pet_reader:
    if(var[0] == '\n'):
        continue
    var[5] = var[5].replace("'","")
    var[5] = var[5].replace('"','')
    pet_list.append(var)
pet_read.close()

i = 1
for row in pet_list :
    sql = "insert into petition (Petition_ID,Petition_Agree_Number,Petition_Name,Petition_Body) values({},'{}','{}','{}')".format(i,row[3],row[4],row[5])
    i+=1
    curs.execute(sql)
conn.commit()
conn.close()
