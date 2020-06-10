const mysql = require('mysql');  //My-sql을 사용하였다.
const pool = mysql.createPool({  //커넥션 생성
    host: 'database-1.cg0acc768it6.us-east-1.rds.amazonaws.com',
    user: 'admin',
    database: 'os_db',
    password : '41545737!'
  });

module.exports = function(app, fs)
{
     app.get('/',function(req,res){
       pool.getConnection(function(error,con){
         con.query('select * from twitter', function(err, rows1, fields){
           con.query('select * from naver', function(err, rows2, fields){
             con.query('select * from youtube', function(err, rows3, fields){
                     res.render('index', {twitter:rows1,
                       naver:rows2,
                       party:rows3,
                       title: "MY HOMEPAGE",
                       length: 5})
                       con.release();
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

       app.get('/twitter/1/Search/', function(req, res) {
       pool.getConnection(function(error,con){
         var _title = req.query.title;
         var myQuery = "select * from twitter where Twitter_Text like '%" + _title + "%'";
             con.query(myQuery, function(err, rows, fields){
                     res.render('twitter', {
                       twitter: rows,
                       leng: Object.keys(rows).length,
                       title: "MY HOMEPAGE",
                       length: 5})
                       con.release();
             })
           })
         });

         app.get('/twitter/2/Search/', function(req, res) {
         pool.getConnection(function(error,con){
           var _title = req.query.title;
           var myQuery = "select * from twitter where Twitter_Text like '%" + _title + "%'";
           var myQuery1 = "select * from twitter where Twitter_Name like '%" + _title + "%'";
           var upQuery = "insert User_Twitter(User_ID,Twitter_ID) select 0,Twitter_ID from twitter where Twitter_Text like '%" + _title + "%'";
           var upQuery1 = "insert User_Twitter(User_ID,Twitter_ID) select 0,Twitter_ID from twitter where Twitter_Name like '%" + _title + "%'";
               con.query(myQuery, function(err, rows, fields){
                 con.query(myQuery1, function(err, rows1, fields){
                   con.query(upQuery, function(err, rows2, fields){
                     con.query(upQuery1, function(err, rows3, fields){
                       res.render('twitter2', {
                         twitter: rows,
                         twitter1: rows1,
                         leng: Object.keys(rows).length,
                         leng1: Object.keys(rows1).length,
                         title: "MY HOMEPAGE",
                         length: 5})
                         con.release();
                       })
                 })
               })
              })
            })
          });

          app.get('/youtube/1/Search/', function(req, res) {
          pool.getConnection(function(error,con){
            var _title = req.query.title;
            var myQuery = "select * from youtube where Youtube_Link ='" + _title + "'";
                con.query(myQuery, function(err, rows, fields){
                        res.render('youtube', {
                          youtube: rows,
                          leng: Object.keys(rows).length,
                          title: "MY HOMEPAGE",
                          length: 5})
                          con.release();
                })
              })
            });
            app.get('/youtube/2/Search/', function(req, res) {
            pool.getConnection(function(error,con){
              var _title = req.query.title;
              var myQuery = "select * from youtube where Youtube_Text like '%" + _title + "%'";
              var myQuery2 = "select * from youtube where Youtube_Name like '%" + _title + "%'";
              var upQuery3 = "insert User_Youtube (User_ID,Youtube_ID) select 0,Youtube_ID from youtube where Youtube_Text like '%" + _title + "%';";
              var upQuery4 = "insert User_Youtube (User_ID,Youtube_ID) select 0,Youtube_ID from youtube where Youtube_Name like '%" + _title + "%';";
                  con.query(myQuery, function(err, rows1, fields){
                    con.query(myQuery2, function(err, rows2, fields){
                      con.query(upQuery3, function (err, rows3, fields){
                        con.query(upQuery4, function (err,rows4, fields){
                          console.log(myQuery);
                          res.render('youtube2', {
                            youtube_text: rows1,
                            youtube_name: rows2,
                            leng1: Object.keys(rows1).length,
                            leng2: Object.keys(rows2).length,
                            title: "MY HOMEPAGE",
                            length: 5})
                            con.release();
                          })
                       })
                    })
                  })
                })
              });

           app.get('/naver/1/Search/', function(req, res) {
           pool.getConnection(function(error,con){
             var _title = req.query.title;
             var myQuery = "select * from naver where Naver_Link like '%" + _title + "%'";
                 con.query(myQuery, function(err, rows, fields){
                         res.render('naver', {
                           naver: rows,
                           leng: Object.keys(rows).length,
                           title: "MY HOMEPAGE",
                           length: 5})
                           con.release();
                 })
               })
             });

           app.get('/naver/2/Search/', function(req, res) {
           pool.getConnection(function(error,con){
             var _title = req.query.title;
             var myQuery = "select * from naver where Naver_Text like '%" + _title + "%'";
             var myQuery1 = "select * from naver where Naver_Name like '%" + _title + "%'";
             var upQuery = "insert User_Naver(User_ID,Naver_ID) select 0,Naver_ID from naver where Naver_Text like '%" + _title + "%'";
             var upQuery1 = "insert User_Naver(User_ID,Naver_ID) select 0,Naver_ID from naver where Naver_Name like '%" + _title + "%'";
                 con.query(myQuery, function(err, rows, fields){
                   con.query(myQuery1, function(err, rows1, fields){
                     con.query(upQuery, function(err, rows2, fields){
                       con.query(upQuery1, function(err, rows3, fields){
                         res.render('naver2', {
                           naver: rows,
                           naver1: rows1,
                           leng: Object.keys(rows).length,
                           leng1: Object.keys(rows1).length,
                           title: "MY HOMEPAGE",
                           length: 5})
                           con.release();
                         })
                   })
                 })
                })
               })
             });

     app.get('/Home', function(req, res){
       pool.getConnection(function(error,con){
         con.query('select * from twitter', function(err, rows1, fields){
           con.query('select * from naver', function(err, rows2, fields){
             con.query('select * from youtube', function(err, rows3, fields){
                     res.render('index', {twitter:rows1,
                       naver:rows2,
                       youtube:rows3,
                       title: "MY HOMEPAGE",
                       length: 5})
                       con.release();
             })
           })
         })
       })
     });

     app.get('/youtube', function(req,res){
      res.render('youtube_search',{
        title: "MY HOMEPAGE",
        length: 5
      })
     });

     app.get('/twitter', function(req,res){
      res.render('twitter_search',{
        title: "MY HOMEPAGE",
        length: 5
      })
     });

     app.get('/naver', function(req,res){
      res.render('naver_search',{
        title: "MY HOMEPAGE",
        length: 5
      })
     });

     app.get('/login', function(req,res){
       pool.getConnection(function (error, con) {
           var myQuery = 'select * from naver where Naver_ID IN (select Naver_ID from User_Naver where User_ID = '+ 0 + ')';
           var myQuery1 = 'select * from twitter where Twitter_ID IN (select Twitter_ID from User_Twitter where User_ID = ' + 0 + ')';
           var myQuery2 = 'select * from youtube where Youtube_ID IN (select Youtube_ID from User_Youtube where User_ID = ' + 0 + ')';
           con.query(myQuery, function (err, rows, fields) {
               con.query(myQuery1, function (err, rows1, fields) {
                 con.query(myQuery2,function(err,rows2,fields){
                   res.render('login', {
                       _twitter: rows1,
                       _naver: rows,
                       _youtube: rows2,
                       lengTwi: Object.keys(rows1).length,
                       lengNav: Object.keys(rows).length,
                       lengYou: Object.keys(rows2).length,
                       title: "MY HOMEPAGE",
                       length: 5
                   })
                   con.release();
               })
           })
         })
       })
   });

}
