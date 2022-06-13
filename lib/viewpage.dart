
import 'package:flutter/material.dart';
import 'package:notedatabase/adddata.dart';
import 'package:notedatabase/myclass.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class viewpage extends StatefulWidget {


  @override
  _viewpageState createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  
  TextEditingController sr=TextEditingController();
  List<myclass> list=[];
  List<myclass> templist=[];
  Database? db;
  bool fav=false;
  String qry="";
  bool search=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gatalldata();
    setState(() {
    });
  }

  gatalldata()
  {
    model().createdatabase().then((value)  async{
      db=value;
      qry ="select * from login";

      value.rawQuery(qry).then((value) {
        setState(() {
          for(int i=0;i<value.length;i++)
            {
              list.add(myclass.fromMap(value[i]));
              templist.add(myclass.fromMap(value[i]));
            }
        });
      });
      print(list);
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: search?AppBar(
        backgroundColor: Colors.black26,
        title: TextField(decoration: InputDecoration(

        ),controller: sr,onChanged: (value) {
          setState(() {
            templist.clear();
            for(int i=0;i<list.length;i++)
              {
                if(list[i].title!.toLowerCase().contains(value.toLowerCase()))
                  {
                    templist.add(list[i]);
                  }
              }
          });
        },),
        actions: [
          IconButton(onPressed: () {
            setState(() {
              search=!search;
            });
          }, icon: Icon(Icons.clear))
        ],
      ):
      AppBar(
        backgroundColor: Colors.black26,
        title: Text("Note"),
        actions: [

          IconButton(onPressed: () {
            setState(() {
              search=!search;
            });
          }, icon: Icon(Icons.search))
        ],  
      ),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(itemCount: templist.length,itemBuilder: (context, index) {

          return Container(
            margin: EdgeInsets.only(left: 10,top: 10,right: 10),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle

            ),
            child: ListTile(
              title: Text("${templist[index].title}"),
              subtitle: Text("${templist[index].note}"),
              leading: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black26),
                child: Text("${index+1}"),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () async {
                    // myclass id =list![];
                    String qry ="delete from login where id = '${list[index].id}'";
                    await db!.rawDelete(qry);

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return viewpage();
                    },));
                  }, icon: Icon(Icons.delete)),

                  IconButton(onPressed:  () {

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return adddata("update",list[index].id,list[index].title,list[index].note);

                    },));
                  }, icon: Icon(Icons.edit)),
                ],
              ) ,
            ),
          );
        },),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.black26,onPressed: () {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return adddata("insert");
        },));
      },child: Icon(Icons.add),
      
      ),
    );
  }
}
