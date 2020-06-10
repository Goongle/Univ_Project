from pymongo import MongoClient

client = MongoClient()

from pymongo import MongoClient
client = MongoClient()
# 클래스 객체 할당

client = MongoClient('localhost', 27017)
# localhost: ip주소
# 27017: port 번호

'''
DB_HOST = 'XXX.XX.XX.XXX:27017'
DB_ID = 'root'
DB_PW = 'PW'

client = MongoClient('mongodb://%s:%s@%s' % (DB_ID, DB_PW, DB_HOST))
'''


db = client["test"]
# DB 이름 입력
collection = db["coll_이름"]
# collection = collection 이름 입력


import datetime
post = {
"author" : "Mike",
"text" : "My first blog post!",
"tags" : ["mongodb", "python", "pymongo"],
"date": datetime.datetime.utcnow()
}

# document 예시


coll = db.collection
coll.insert(post)
# post_id = coll.insert(post)

new_posts = [{},{}]
coll.insert(new_posts)

# 리스트 화 시켜서 여러 개 추가도 가능

coll.find_one()
# 콜렉션 저장도니 순서 중 가장 첫번째 값 사용. 조건 쿼리를 괄호 내에 넣을 수 있음

posts.count()
# 도큐먼트 갯수 세기
