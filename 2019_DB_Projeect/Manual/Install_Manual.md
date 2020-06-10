1. git clone ssh://git@khuhub.khu.ac.kr:12959/2019-2-database/team-5.git을 통해
프로젝트를 다운 받습니다.

2. 이후 Source 폴더에 DB_SCHEMA에 있는 All_insert.py를 실행시켜줍니다.

3. 그 다음으로는 Agenad, Article, Member, Petition을 차례대로 실행시켜 줍니다.

4. 실행이 완료 될 때 까지 기다린 후 나머지 py 파일들을 전부 실행시킵니다.

5. mysql workbench에 들어가 데이터가 잘 들어갔는지 확인합니다.

6. 이후 
Insert mydb.user(User_Id, User_Password)
Values(0,"1234")
다음 쿼리문을 실행 시켜줍니다.

7. 유저의 입력까지 끝난후 Web_Design으로 갑니다.

8. Web_Design 폴더에서 router 폴더에 있는 main.js를 열어 맨윗 부분에
user: 'root', database: 'mydb', password: ''
부분을 자신의 workbench에 맞게 맞춰줍니다.

9. 이후 다시 이전 Web_Design 내부로 돌아와 마우스 우클릭을 통해 git bash here을
한 후, node server.js를 쳐줍니다.

10. 브라우저를 킨 후 localhost:3000을 입력하면 실행 됩니다.