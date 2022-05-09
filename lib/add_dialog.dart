import 'package:flutter/material.dart';
class add_dialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     title: Text("add"),
        content: TextField(
          
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ];
  
  }

}