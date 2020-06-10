insert domain (Domain_Name) values ('정치');
insert domain (Domain_Name) values ('외교');
insert domain (Domain_Name) values ('경제');
insert domain (Domain_Name) values ('국방');
insert domain (Domain_Name) values ('연예');
insert domain (Domain_Name) values ('문화');
insert domain (Domain_Name) values ('사회');

select * from party;
insert party (Party_Name) values ('더불어민주당'); /* 이해찬 등록 */
insert party (Party_Name) values ('자유한국당'); /* 황교안 없음 */
insert party (Party_Name) values ('바른미래당');/* 손학규 없음 */
insert party (Party_Name) values ('정의당');/* 심상정 있음 */
insert party (Party_Name) values ('민주평화당');/* 정동영 있음 */
insert party (Party_Name) values ('민중당');/* 이상규 없음 */
insert party (Party_Name) values ('무소속');/* 대표 없음 */
insert party (Party_Name) values ('우리공화당'); /* 대표 모름 */
select * from member_of_congress where Member_of_Congress_Name= '이상규';

insert member_of_congress (member_of_congress_id,member_of_congress_name,
                          member_of_congress_party) values (296,'장준영','무소속');
insert member_of_congress (member_of_congress_id,member_of_congress_name,
                          member_of_congress_party) values (297,'장수창','무소속');
insert member_of_congress (member_of_congress_id,member_of_congress_name,
                          member_of_congress_party) values (298,'김건','무소속');
insert member_of_congress (member_of_congress_id,member_of_congress_name,
                          member_of_congress_party) values (299,'김효준','무소속');

/*                          
update party set Floor_leader = 2 where Party_name = '더불어민주당';
update party set Floor_leader = 296 where Party_name = '무소속';
update party set Floor_leader = 239 where Party_name = '민주평화당';
update party set Floor_leader = 67 where Party_name = '민중당';
update party set Floor_leader = 20 where Party_name = '바른미래당';
update party set Floor_leader = 260 where Party_name = '우리공화당';
update party set Floor_leader = 279 where Party_name = '자유한국당';
update party set Floor_leader = 63 where Party_name = '정의당';
-- 더민주 2 강병원
-- 무소속 296 장준영
-- 민주평화당 239 정동영
-- 민중당 67 김종훈
-- 바른미래당 20 김관영
-- 우리공화당 260 조원진
-- 자유한국당 279 추경호
-- 정의당 63 김종대

select * from party;
*/