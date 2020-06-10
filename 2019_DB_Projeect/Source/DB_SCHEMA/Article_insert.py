import pymysql
import csv
import random
conn = pymysql.connect(host = 'localhost', user = 'root', password ='xkdlrj0',db= 'mydb',charset = 'utf8')
curs = conn.cursor()
'''
Article_list = [] # 순서 키워드 날짜 제목 신문사 내용요약본 링크
Article_read = open('News_result.csv','r')
Article_reader = csv.reader(Article_read)
for var in Article_reader :
    if(var[0] == '\n'):
        continue
    var[3] = var[3].replace("'","")
    var[3] = var[3].replace('"','')
    var[5] = var[5].replace("'","")
    var[5] = var[5].replace('"','')
    Article_list.append(var)
Article_read.close()
random_list = ['경제','국방','문화','사회','연예','외교','정치']

for row in Article_list :
    random_number = random.randrange(0,7)
    sql = "insert into article (Article_ID,Article_Keyword,article_Date,article_title,article_body,article_link,domain_name) values ({},'{}','{}','{}','{}','{}','{}')".format(row[0],row[1],row[2],row[3],row[5],row[6],random_list[random_number])
    curs.execute(sql)
'''
Article_list2 = [] # 순서 키워드 날짜 제목 신문사 내용요약본 링크
Article_read2 = open('News_result2.csv','r')
Article_reader2 = csv.reader(Article_read2)
for var in Article_reader2 :
    if(var[0] == '\n'):
        continue
    var[3] = var[3].replace("'","")
    var[3] = var[3].replace('"','')
    var[5] = var[5].replace("'","")
    var[5] = var[5].replace('"','')
    Article_list2.append(var)
Article_read2.close()
random_list = ['경제','국방','문화','사회','연예','외교','정치']

for row in Article_list2 :
    random_number = random.randrange(0,7)
    sql = "insert into article (Article_ID,Article_Keyword,article_Date,article_title,article_body,article_link,domain_name) values ({},'{}','{}','{}','{}','{}','{}')".format(row[0],row[1],row[2],row[3],row[5],row[6],random_list[random_number])
    curs.execute(sql)

conn.commit()
conn.close()
