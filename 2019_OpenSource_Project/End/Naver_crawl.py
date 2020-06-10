from selenium import webdriver
from selenium.common import exceptions
from bs4 import BeautifulSoup
import time
import pymysql

conn = pymysql.connect(host = 'database-1.cg0acc768it6.us-east-1.rds.amazonaws.com', user = 'admin', password ='41545737!',db= 'os_db',charset = 'utf8')
curs = conn.cursor()
def getData(url):
    ## chrome option
    options = webdriver.ChromeOptions()
    #options.add_argument('headless')
    #options.add_argument("disable-gpu")
    _url = url # 크롤링할 URL
    webDriver = "C:\\Users\\KimGun\\Desktop\\chromedriver_win32\\chromedriver.exe"  # 내 웹드라이버 위치
    driver = webdriver.Chrome(webDriver,chrome_options=options)
    #driver = webdriver.Chrome(webDriver)
    driver.get(_url)
    pageCnt = 0
    driver.implicitly_wait(3) # 페이지가 다 로드 될때까지 기다리게함
    try:
        while True: # 댓글 페이지 끝날때까지 돌림
            #driver의 find_element_by_css_selector함수로 '네이버 뉴스'의 댓글 '더보기' 버튼을 찾아서 계속 클릭해준다(끝까지)
            time.sleep(0.5)
            driver.find_element_by_css_selector(".u_cbox_btn_more").click()
            pageCnt = pageCnt+1

    except exceptions.ElementNotVisibleException as e: # 페이지가 끝남
        pass

    except Exception as e: # 다른 예외 발생시 확인
        print(e)

    pageSource = driver.page_source # 페이지 소스를 따와서
    result = BeautifulSoup(pageSource, "lxml") # 빠르게 뽑아오기 위해 lxml 사용
    # nickname, text, time을 raw하게 뽑아온다
    comments_raw = result.find_all("span", {"class" : "u_cbox_contents"})
    nicknames_raw = result.find_all("span", {"class" : "u_cbox_nick"})
    times_raw = result.find_all("span", {"class" : "u_cbox_date"})



    # nickname, text, time 값 만을 뽑아내어 리스트로 정리한다
    comments = [comment.text for comment in comments_raw]
    nicknames = [nickname.text for nickname in nicknames_raw]
    times = [time.text for time in times_raw]


    naverNewsList = []

    for i in range(len(comments)):
        info_dic = {'userID' : nicknames[i], 'comment' : comments[i], 'time' : times[i]}
        naverNewsList.append(info_dic)

    print(naverNewsList)
    return naverNewsList
    #driver.quit()

_url = input('검색하고자 하는 url을 입력해주세요: ')
print('comment_list를 가져오는 중.....')
cList = getData(_url)
i = 194
for row in cList : ## Name, Text, time
    temp = row['comment'].replace("'",'')
    sql = "insert into naver (Naver_ID,Naver_Name,Naver_Text,Naver_Date,Naver_link) values({},'{}','{}','{}','{}')".format(i,row['userID'],temp,row['time'],_url)
    print(sql)
    i = i + 1
    curs.execute(sql)
conn.commit()
conn.close()
