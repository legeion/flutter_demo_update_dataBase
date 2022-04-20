import 'package:flutter/material.dart';
import 'package:flutter_demo_update_db/model/course.dart';

import '../db/dbhelper.dart';
import 'coursedetails.dart';
import 'courseupdate.dart';
import 'newcourse.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DataBaseApp helper;

  @override
  void initState() {
    super.initState();
    helper = DataBaseApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Database'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NewCourse())),
          )
        ],
      ),
      body: FutureBuilder(
        future: helper.allCourses(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  Course course = Course.fromMap(snapshot.data[i]);
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                          '${course.name} - ${course.hours} hours - ${course.level}'),
                      subtitle: Text(course.content.substring(0, 13)),
                      trailing: Column(
                        children: <Widget>[
                          Expanded(
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  helper.delete(course.id);
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        CourseUpdate(course)));
                              },
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CourseDetails(course)));
                      },
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
