import 'package:flutter/material.dart';
import 'package:notedatabase/myclass.dart';
import 'package:notedatabase/viewpage.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class adddata extends StatefulWidget {
  String? type;
  int? id;
  String? title,note;

  adddata([this.type,this.id, this.title, this.note]);

  @override
  _adddataState createState() => _adddataState();
}

class _adddataState extends State<adddata> {

  Database? db;
  TextEditingController ttitle=TextEditingController();
  TextEditingController tnote=TextEditingController();
  bool titlest=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filldataforupdate();
    model().createdatabase().then((value){
      db =value;
    });
  }

  filldataforupdate()
  {

    if(widget.type=="update")
      {
        ttitle.text=widget.title!;
        tnote.text=widget.note!;
      }

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.black26,
        actions: [
          IconButton(onPressed: () async{

            String title=ttitle.text;
            String note=tnote.text;

            if(title.isEmpty)
              {
                titlest=true;
                setState(() {
                });
              }

           else if(widget.type=="insert")
            {
              String qry ="insert into login(title, note) values('$title','$note')";
              int a= await db!.rawInsert(qry);
              print(a);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return viewpage();
              },));

            }
            else
            {

              String qry ="update login set title= '$title', note = '$note' where id = '${widget.id}'";
              int a = await db!.rawUpdate(qry);
              print(a);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return viewpage();
              },));
            }


          }, icon: Icon(Icons.check))
        ],

      ),
      body: Container(

        height: double.infinity,
        width: double.infinity,
        color: Colors.white,

        child: Column(

          children: [

            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                color: Colors.white,

              ),


              child: TextField(controller: ttitle,
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                  errorText: titlest ? "Please Enter Title" : null,
                  errorStyle: TextStyle(color: Colors.black26,fontSize: 15),
                  errorBorder: OutlineInputBorder(),


                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,

              ),

              child: TextField(controller: tnote,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(

                    border: InputBorder.none,
                  hintText: "Note",
                  hintStyle: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    ), onWillPop: goBack);
  }
  Future<bool> goBack()
  {

    // Navigator.pop(context);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return viewpage();
    },));
    return Future.value();
  }
}
