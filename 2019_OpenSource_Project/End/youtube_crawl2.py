import downloader
import pymysql
import csv
import random

conn = pymysql.connect(host = 'database-1.cg0acc768it6.us-east-1.rds.amazonaws.com', user = 'admin', password ='41545737!',db= 'os_db',charset = 'utf8')
curs = conn.cursor()

def call_main ():
    print(' Comment Thread 생성중 \n')
    print(' **************************************************************')
    print(' **************************************************************')
    print(' **************************************************************')
    print(' **************** 생성 완료 정보를 입력하세요. ****************  ')
    print(' **************************************************************')
    print(' **************************************************************')
    print(' **************************************************************')
    a = downloader.main()
    return a

CommentList = call_main() ## dic 형식으로 cid, text, time, author
i = 0
for row in CommentList :
    temp = row['text'].replace("'",'')
    sql = "insert into youtube (Youtube_ID,Youtube_Text,Youtube_Date,Youtube_Name,Youtube_Link) values({},'{}','{}','{}','{}')".format(i,temp,row['time'],row['author'],row['link'])
    print(sql)
    i = i + 1
    curs.execute(sql)
conn.commit()
conn.close()
