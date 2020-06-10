const mysql = require('mysql');  //My-sql을 사용하였다.
const pool = mysql.createPool({  //커넥션 생성
    host: 'localhost',
    user: 'root',
    database: 'mydb',
    password : '1234'
  });

module.exports = function(app, fs)
{
     app.get('/',function(req,res){
       pool.getConnection(function(error,con){
         con.query('select * from agenda', function(err, rows1, fields){
           con.query('select * from article', function(err, rows2, fields){
             con.query('select * from party', function(err, rows3, fields){
               con.query('select * from member_of_congress', function(err, rows4, fields){
                 con.query('select * from domain', function(err, rows5, fields){
                   con.query('select * from petition', function(err, rows6, fields){
                     res.render('index', {agenda:rows1,
                       article:rows2,
                       party:rows3,
                       member_of_congress:rows4,
                       domain:rows5,
                       petition:rows6,
                       title: "MY HOMEPAGE",
                       length: 5})
                       con.release();
                   })
                 })
               })
             })
           })
         })
       })
     });
     app.get('/Search', function(req, res) {
     pool.getConnection(function(error,con){
       var _title = req.query.title;
       var myQuery = "select * from member_of_congress where Member_of_Congress_Name like '%" + _title + "%'";
       var upQuery = "insert search_user_member(Member_ID,User_ID) select Member_of_Congress_ID,0 from member_of_congress where Member_of_Congress_Name like '%" + _title + "%'";
       var myQuery1 = "select * from party where Party_Name like '%" + _title + "%'";
       var myQuery2 = "select * from article where Article_Body like '%" + _title + "%'";
       var upQuery2 = "insert search_user_article(article_ID,User_ID) select Article_ID,0 from article where Article_Body like '%" + _title + "%'";
       var myQuery3 = "select * from agenda where Agenda_Body like '%" + _title + "%'";
       var upQuery3 = "insert search_user_agenda(agenda_ID,User_ID) select Agenda_ID,0 from agenda where Agenda_Body like '%" + _title + "%'";
       var myQuery4 = "select * from petition where Petition_Body like '%" + _title + "%'";
           con.query(myQuery, function(err, rows, fields){
             con.query(myQuery1, function(err, rows1, fields){
               con.query(myQuery2, function(err,rows2,fileds){
                 con.query(myQuery3, function (err,rows3,fileds){
                   con.query(myQuery4, function (err,rows4,fileds){
                     con.query(upQuery, function (err,rows5,fileds){
                       con.query(upQuery2, function (err,rows6,fileds){
                         con.query(upQuery3, function (err,rows7,fileds){

                   res.render('search', {
                     _member: rows,
                     _party: rows1,
                     _article: rows2,
                     _agenda : rows3,
                     _petition : rows4,
                     lengMem: Object.keys(rows).length,
                     lengPar: Object.keys(rows1).length,
                     lengArt: Object.keys(rows2).length,
                     lengAge: Object.keys(rows3).length,
                     lengPet: Object.keys(rows4).length,
                     title: "MY HOMEPAGE",
                     length: 5})
                     con.release();
                          })
                        })
                      })

                   })
                 })
               })
             })
           })
         })
       });

     app.get('/Home', function(req, res){
       pool.getConnection(function(error,con){
         con.query('select * from agenda', function(err, rows1, fields){
           con.query('select * from article', function(err, rows2, fields){
             con.query('select * from party', function(err, rows3, fields){
               con.query('select * from member_of_congress', function(err, rows4, fields){
                 con.query('select * from domain', function(err, rows5, fields){
                   con.query('select * from petition', function(err, rows6, fields){
                     res.render('index', {agenda:rows1,
                       article:rows2,
                       party:rows3,
                       member_of_congress:rows4,
                       domain:rows5,
                       petition:rows6,
                       title: "MY HOMEPAGE",
                       length: 5})
                       con.release();
                   })
                 })
               })
             })
           })
         })
       })
     });


     app.get('/login', function(req,res){
       pool.getConnection(function (error, con) {
           var myQuery = 'select * from agenda where Agenda_ID IN (select Agenda_ID from search_user_agenda where User_ID = '+ 0 + ')';
           var myQuery1 = 'select * from article where Article_ID IN (select Article_ID from search_user_article where User_ID = ' + 0 + ')';
           var myQuery2 = 'select * from member_of_congress where Member_of_Congress_ID IN (select Member_ID from search_user_member where User_ID = ' + 0 + ')';
           con.query(myQuery, function (err, rows, fields) {
               con.query(myQuery1, function (err, rows1, fields) {
                 con.query(myQuery2,function(err,rows2,fields){
                   res.render('login', {
                       _article: rows1,
                       _agenda: rows,
                       _member: rows2,
                       lengArt: Object.keys(rows1).length,
                       lengAge: Object.keys(rows).length,
                       lengMem: Object.keys(rows2).length,
                       title: "MY HOMEPAGE",
                       length: 5
                   })
                   con.release();
               })
           })
         })
       })
   });

     app.get('/Member/:page', function(req, res){
       var page = req.params.page;
       var page_size = 10;
       var page_list_size = 10;
       var no = "";
       pool.getConnection(function(error,con){
         con.query('select * from agenda', function(err, rows1, fields){
           con.query('select * from article', function(err, rows2, fields){
             con.query('select * from party', function(err, rows3, fields){
               con.query('select * from member_of_congress', function(err, rows4, fields){
                 con.query('select * from domain', function(err, rows5, fields){
                   con.query('select * from petition', function(err, rows6, fields){
                     var totalPageCount = Object.keys(rows4).length;

                     if(totalPageCount < 0)
                     {
                       totalPageCount = 0
                     }
                     var totalPage = Math.ceil(totalPageCount / page_size);
                     var totalSet = Math.ceil(totalPage / page_list_size); //전체 세트수
                     var curSet = Math.ceil(page / page_list_size) // 현재 셋트 번호
                     var startPage = ((curSet - 1) * 10) + 1 //현재 세트내 출력될 시작 페이지
                     var endPage = (startPage + page_list_size) - 1; //현재 세트내 출력될 마지막 페이
                     if (page < 0)
                     {
                        no = 0
                     }

                     else
                     {
                     //0보다 크면 limit 함수에 들어갈 첫번째 인자 값 구하기
                        no = (page - 1) * 10
                     }
                     res.render('member', {agenda:rows1,
                       article:rows2,
                       party:rows3,
                       member_of_congress:rows4,
                       domain:rows5,
                       petition:rows6,
                       page: page,
                       leng: Object.keys(rows4).length-1,
                       pass: true,
                       page_list_size: page_list_size,
                       page_size: page_size,
                       totalPage: totalPage,
                       totalSet: totalSet,
                       curSet: curSet,
                       startPage: startPage,
                       endPage: endPage,
                       title: "MY HOMEPAGE",
                       length: 5})
                       con.release();
                   })
                 })
               })
             })
           })
         })
       })
     });

     app.get('/Agenda/:page', function(req, res){
       var page = req.params.page;
       var page_size = 10;
       var page_list_size = 10;
       var no = "";
       pool.getConnection(function(error,con){
         con.query('select * from agenda', function(err, rows1, fields){
           con.query('select * from article', function(err, rows2, fields){
             con.query('select * from party', function(err, rows3, fields){
               con.query('select * from member_of_congress', function(err, rows4, fields){
                 con.query('select * from domain', function(err, rows5, fields){
                   con.query('select * from petition', function(err, rows6, fields){
                     var totalPageCount = Object.keys(rows1).length;

                     if(totalPageCount < 0)
                     {
                       totalPageCount = 0
                     }
                     var totalPage = Math.ceil(totalPageCount / page_size);
                     var totalSet = Math.ceil(totalPage / page_list_size); //전체 세트수
                     var curSet = Math.ceil(page / page_list_size) // 현재 셋트 번호
                     var startPage = ((curSet - 1) * 10) + 1 //현재 세트내 출력될 시작 페이지
                     var endPage = (startPage + page_list_size) - 1; //현재 세트내 출력될 마지막 페이
                     if (page < 0)
                     {
                        no = 0
                     }

                     else
                     {
                     //0보다 크면 limit 함수에 들어갈 첫번째 인자 값 구하기
                        no = (page - 1) * 10
                     }
                     res.render('agenda', {agenda:rows1,
                       article:rows2,
                       party:rows3,
                       member_of_congress:rows4,
                       domain:rows5,
                       petition:rows6,
                       page: page,
                       leng: Object.keys(rows1).length-1,
                       pass: true,
                       page_list_size: page_list_size,
                       page_size: page_size,
                       totalPage: totalPage,
                       totalSet: totalSet,
                       curSet: curSet,
                       startPage: startPage,
                       endPage: endPage,
                       title: "MY HOMEPAGE",
                       length: 5})
                       con.release();
                   })
                 })
               })
             })
           })
         })
       })
     });
     app.get('/Articles/:page', function(req, res){
       var page = req.params.page;
       var page_size = 10;
       var page_list_size = 10;
       var no = "";
       pool.getConnection(function(error,con){
         con.query('select * from agenda', function(err, rows1, fields){
           con.query('select * from article', function(err, rows2, fields){
             con.query('select * from party', function(err, rows3, fields){
               con.query('select * from member_of_congress', function(err, rows4, fields){
                 con.query('select * from domain', function(err, rows5, fields){
                   con.query('select * from petition', function(err, rows6, fields){
                     var totalPageCount = Object.keys(rows2).length;

                     if(totalPageCount < 0)
                     {
                       totalPageCount = 0
                     }
                     var totalPage = Math.ceil(totalPageCount / page_size);
                     var totalSet = Math.ceil(totalPage / page_list_size); //전체 세트수
                     var curSet = Math.ceil(page / page_list_size) // 현재 셋트 번호
                     var startPage = ((curSet - 1) * 10) + 1 //현재 세트내 출력될 시작 페이지
                     var endPage = (startPage + page_list_size) - 1; //현재 세트내 출력될 마지막 페이
                     if (page < 0)
                     {
                        no = 0
                     }

                     else
                     {
                     //0보다 크면 limit 함수에 들어갈 첫번째 인자 값 구하기
                        no = (page - 1) * 10
                     }
                     res.render('article', {agenda:rows1,
                       article:rows2,
                       party:rows3,
                       member_of_congress:rows4,
                       domain:rows5,
                       petition:rows6,
                       page: page,
                       leng: Object.keys(rows2).length-1,
                       pass: true,
                       page_list_size: page_list_size,
                       page_size: page_size,
                       totalPage: totalPage,
                       totalSet: totalSet,
                       curSet: curSet,
                       startPage: startPage,
                       endPage: endPage,
                       title: "MY HOMEPAGE",
                       length: 5})
                       con.release();
                   })
                 })
               })
             })
           })
         })
       })
     });
     app.get('/Petition/:page', function(req, res, next){
       var page = req.params.page;
       var page_size = 10;
       var page_list_size = 10;
       var no = "";
       pool.getConnection(function(error,con){
         con.query('select * from agenda', function(err, rows1, fields){
           con.query('select * from article', function(err, rows2, fields){
             con.query('select * from party', function(err, rows3, fields){
               con.query('select * from member_of_congress', function(err, rows4, fields){
                 con.query('select * from domain', function(err, rows5, fields){
                   con.query('select * from petition', function(err, rows6, fields){
                     var totalPageCount = Object.keys(rows6).length;

                     if(totalPageCount < 0)
                     {
                       totalPageCount = 0
                     }
                     var totalPage = Math.ceil(totalPageCount / page_size);
                     var totalSet = Math.ceil(totalPage / page_list_size); //전체 세트수
                     var curSet = Math.ceil(page / page_list_size) // 현재 셋트 번호
                     var startPage = ((curSet - 1) * 10) + 1 //현재 세트내 출력될 시작 페이지
                     var endPage = (startPage + page_list_size) - 1; //현재 세트내 출력될 마지막 페이
                     if (page < 0)
                     {
                        no = 0
                     }

                     else
                     {
                     //0보다 크면 limit 함수에 들어갈 첫번째 인자 값 구하기
                        no = (page - 1) * 10
                     }

                     res.render('petition', {agenda:rows1,
                       article:rows2,
                       party:rows3,
                       member_of_congress:rows4,
                       domain:rows5,
                       petition:rows6,
                       page: page,
                       leng: Object.keys(rows6).length-1,
                       pass: true,
                       page_list_size: page_list_size,
                       page_size: page_size,
                       totalPage: totalPage,
                       totalSet: totalSet,
                       curSet: curSet,
                       startPage: startPage,
                       endPage: endPage,
                       title: "MY HOMEPAGE",
                       length: 5})
                       con.release();
                   })
                 })
               })
             })
           })
         })
       })
     });

     app.get('/Member/1/:Member_ID', function (req, res) {
        pool.getConnection(function (error, con) {
            Member_ID = req.params.Member_ID;
            var myQuery = 'select * from agenda where Agenda_ID IN (select Agenda_ID from include_member_agenda_ where Member_ID = '+ Member_ID + ')';
            var myQuery1 = 'select * from article where Article_ID IN (select Article_ID from exist_member_article where Member_ID = ' + Member_ID + ')';
            var myQuery2 = 'insert into search_user_member (Member_ID,User_ID) values (' + Member_ID + ', 0)';
            con.query(myQuery, function (err, rows, fields) {
                con.query(myQuery1, function (err, rows1, fields) {
                  con.query(myQuery2, function(err,rows2,fields){
                    res.render('member1', {
                        _article: rows1,
                        _agenda: rows,
                        lengArt: Object.keys(rows1).length,
                        lengAge: Object.keys(rows).length,
                        title: "MY HOMEPAGE",
                        length: 5
                        })
                    })
                    con.release();
                })
            })
        })
    });


    app.get('/Agenda/1/:Agenda_ID', function(req, res){
     pool.getConnection(function(error,con){
       Agenda_ID = req.params.Agenda_ID;
       var myQuery = 'select * from petition where petition_id in (select petition_id from mva_agenda_petition where agenda_id = ' + Agenda_ID+ ')';
       var myQuery1 = 'select * from article where article_id in (select article_id from mva_agenda_article where agenda_id = ' + Agenda_ID +')';
       var myQuery2 = 'select * from Member_of_congress where member_of_congress_id in (select member_id from include_member_agenda_ where agenda_id =' + Agenda_ID + ')';
       var myQuery3 = 'select * from agenda where agenda_id = ' + Agenda_ID;
       var myQuery4 = 'insert into search_user_agenda (Agenda_ID,User_ID) values (' + Agenda_ID + ', 0)';
           con.query(myQuery, function(err, rows, fields){
             con.query(myQuery1, function(err, rows1, fields){
               con.query(myQuery2, function(err,rows2,fileds){
                 con.query(myQuery3, function (err,rows3,fileds){
                   con.query(myQuery4, function (err,rows4,fileds){
                   res.render('agenda1', {
                     petition: rows,
                     article: rows1,
                     member: rows2,
                     agenda : rows3,
                     leng: Object.keys(rows).length, // petition
                     leng1: Object.keys(rows1).length, // article
                     leng2: Object.keys(rows2).length, // member_of_congress
                     title: "MY HOMEPAGE",
                     length: 5})
                     con.release();
                     })
                 })
               })
             })
           })
         })
       });

    app.get('/Articles/1/:Article_ID', function (req, res) {
        pool.getConnection(function (error, con) {
            Article_ID = req.params.Article_ID;
            var myQuery = 'select * from member_of_congress where Member_of_Congress_ID IN (select Member_ID from exist_member_article where Article_ID = '+ Article_ID + ')';
            var myQuery1 = 'select * from agenda where Agenda_ID IN (select Agenda_ID from mva_agenda_article where Article_ID = '+ Article_ID + ')';
            var myQuery2 = 'insert into search_user_article (Article_ID,User_ID) values (' + Article_ID + ', 0)';
            con.query(myQuery, function (err, rows, fields) {
                con.query(myQuery1, function (err, rows1, fields) {
                  con.query(myQuery2, function(err,rows2,fileds){
                    res.render('article1', {
                        _agenda: rows1,
                        _member: rows,
                        lengAge: Object.keys(rows1).length,
                        lengMem: Object.keys(rows).length,
                        title: "MY HOMEPAGE",
                        length: 5
                        })
                    })
                    con.release();
                })
            })
        })
    });

     app.get('/Petition/1/:Petition_ID', function(req, res){
      pool.getConnection(function(error,con){
        Petition_ID = req.params.Petition_ID;
        var myQuery = 'select * from agenda where Agenda_ID in (select Agenda_ID from mva_agenda_petition where Petition_ID = ' + Petition_ID + ')';
            con.query(myQuery, function(err, rows, fields){
                    res.render('petition1', {
                      agenda: rows,
                      leng: Object.keys(rows).length, // agenda
                      title: "MY HOMEPAGE",
                      length: 5})
                      con.release();
            })
          })
        });

     app.get('/Party/:page', function(req, res){
       var page = req.params.page;
       var page_size = 10;
       var page_list_size = 10;
       var no = "";
       pool.getConnection(function(error,con){
         con.query('select * from agenda', function(err, rows1, fields){
           con.query('select * from article', function(err, rows2, fields){
             con.query('select * from party', function(err, rows3, fields){
               con.query('select * from member_of_congress', function(err, rows4, fields){
                 con.query('select * from domain', function(err, rows5, fields){
                   con.query('select * from petition', function(err, rows6, fields){
                     var totalPageCount = Object.keys(rows3).length;

                     if(totalPageCount < 0)
                     {
                       totalPageCount = 0
                     }
                     var totalPage = Math.ceil(totalPageCount / page_size);
                     var totalSet = Math.ceil(totalPage / page_list_size); //전체 세트수
                     var curSet = Math.ceil(page / page_list_size) // 현재 셋트 번호
                     var startPage = ((curSet - 1) * 10) + 1 //현재 세트내 출력될 시작 페이지
                     var endPage = (startPage + page_list_size) - 1; //현재 세트내 출력될 마지막 페이
                     if (page < 0)
                     {
                        no = 0
                     }

                     else
                     {
                     //0보다 크면 limit 함수에 들어갈 첫번째 인자 값 구하기
                        no = (page - 1) * 10
                     }
                     res.render('party', {agenda:rows1,
                       article:rows2,
                       party:rows3,
                       member_of_congress:rows4,
                       domain:rows5,
                       petition:rows6,
                       page: page,
                       leng: Object.keys(rows3).length-1,
                       pass: true,
                       page_list_size: page_list_size,
                       page_size: page_size,
                       totalPage: totalPage,
                       totalSet: totalSet,
                       curSet: curSet,
                       startPage: startPage,
                       endPage: endPage,
                       title: "MY HOMEPAGE",
                       length: 5})
                       con.release();
                   })
                 })
               })
             })
           })
         })
       })
     });

     app.get('/Party/1/:Party_Name', function(req, res){
      pool.getConnection(function(error,con){
        Party_Name = req.params.Party_Name;
        var myQuery = 'select * from member_of_congress where Member_of_Congress_Party = ' + "'"+Party_Name + "'";
        var myQuery1 = 'select * from member_of_congress where Member_of_Congress_ID  = (select Floor_leader from party where Party_Name = ' + "'"+ Party_Name + "')";
            con.query(myQuery, function(err, rows, fields){
              con.query(myQuery1, function(err, rows1, fields){
                res.render('party1', {
                  leader: rows1,
                  member_of_party:rows,
                  leng: Object.keys(rows).length,
                  title: "MY HOMEPAGE",
                  length: 5})
                con.release();
              })
            })
          })
        });

}
