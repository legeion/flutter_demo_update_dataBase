import 'package:flutter/material.dart';
import 'package:flutter_demo_update_db/model/course.dart';

import '../db/dbhelper.dart';

class NewCourse extends StatefulWidget {
  @override
  _NewCourseState createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  String name, content;
  int hours;
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
        title: Text('New Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter Course name'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                maxLines: 10,
                validator: (value) {
                  return value.length < 3
                      ? 'Course Content five characters'
                      : null;
                },
                decoration: InputDecoration(hintText: 'Enter Course Content'),
                onChanged: (value) {
                  setState(() {
                    content = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter Course hours'),
                onChanged: (value) {
                  setState(() {
                    hours = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () async {
                  Course course = Course(
                      {'name': name, 'content': content, 'hours': hours});
                  int id = await helper.createCourse(course);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
