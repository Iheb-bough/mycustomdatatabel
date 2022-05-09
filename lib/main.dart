
import 'package:flutter/material.dart';
import 'package:flutter_application_3/scrollable_widget.dart';
import 'package:flutter_application_3/user.dart';

import 'package:flutter_application_3/modelbuilder.dart';
import 'package:flutter_application_3/edit_dialog.dart';
import 'package:flutter_application_3/myusers.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Custom Data Table',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My Custom Data Table'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  

  

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formkey=GlobalKey<FormState>();
  String firstName ='';
    String lastName='';
       String age='';

  late List<User> selusers;
late List<User> users;

 int? sortColumnIndex;
bool isAscending = false;
@override
  void initState() {
    selusers= [];
    super.initState();

    this.users = List.of(allUsers);
  }

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: 
         Row(
          children: [
            Expanded(
              child: 
 SingleChildScrollView(child: buildDataTable())),
            
          ],
        
      ),
      
     floatingActionButton: FloatingActionButton(onPressed: (() async {
       await showInformationDialog(context);
            
          }), child: Icon(Icons.add),
          
          backgroundColor: Colors.grey,
          ),  

    );
  

  }

        
    
    Widget buildDataTable() {
    final columns = ['First Name', 'Last Name', 'Age'];

    return DataTable(
      
      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey),
      columnSpacing: 10,
      horizontalMargin: 100,
      showBottomBorder: true,
      checkboxHorizontalMargin: 1.0,
      dividerThickness: 2.0,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(users),
      
    );
     }
    List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      final isAge = column == columns[2];

      return DataColumn(
        onSort: onSort,
        label: Text(column,
        textAlign: TextAlign.center,),
        numeric: isAge,
      );
    }).toList();

  }
   List<DataRow> getRows(List<User> users) => users.map((User user) {

        final  cells = [user.firstName, user.lastName, user.age];

        return DataRow(
          selected: selusers.contains(user),
          onSelectChanged: (val) {
            onselectrow(val!,user);
            
          },
          cells: Utils.modelBuilder(cells, (index, cell) {
            final showEditIcon = index == 0 ;

            return    DataCell(
              
             Text('$cell'),
              showEditIcon: showEditIcon,
              onTap: () {
                switch (index) {
                  case 0:
                    editFirstName(user);
                    break;
                  case 1:
                    editLastName(user);
                    break;
                }
              },
            );
          }),
        );
      }).toList();
      Future editFirstName(User editUser) async {
    final firstName = await showTextDialog(
      context,
      title: 'Change First Name',
      value: editUser.firstName,
    );

    setState(() => users = users.map((user) {
          final isEditedUser = user == editUser;

          return isEditedUser ? user.copy(firstName: firstName) : user;
        }).toList());
  }

  Future editLastName(User editUser) async {
    final lastName = await showTextDialog(
      context,
      title: 'Change Last Name',
      value: editUser.lastName,
    );

    setState(() => users = users.map((user) {
          final isEditedUser = user == editUser;

          return isEditedUser ? user.copy(lastName: lastName) : user;
        }).toList());
  }
  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      users.sort((user1, user2) =>
          compareString(ascending, user1.firstName, user2.firstName));
    } else if (columnIndex == 1) {
      users.sort((user1, user2) =>
          compareString(ascending, user1.lastName, user2.lastName));
    } else if (columnIndex == 2) {
      users.sort((user1, user2) =>
          compareString(ascending, '${user1.age}', '${user2.age}'));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);


      Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(context: context,
    builder: (context){
      final TextEditingController _textEditingController1 = TextEditingController();
    final TextEditingController _textEditingController2 = TextEditingController();
    final TextEditingController _textEditingController3 = TextEditingController();
      return StatefulBuilder(builder: (context,setState){
        return AlertDialog(
          
          content: Form(
            
            key: formkey,
              
              child: Column(
                
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator:  (value) {
                      if(value!.length<2){
                        return 'enter at least two characters';
                      }
                      else  {
                          return null;
                      }
                    },
                    controller: _textEditingController1,
                    textInputAction:TextInputAction.done ,
                    onSaved: (value) => (){},
                    decoration: InputDecoration(hintText: "Enter First Name",
                    border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    
                    controller: _textEditingController2,
                    
                    validator:  (value) {
                      if(value!.length<2){
                        return 'enter at least two characters';
                      }
                      else  {
                          return null;
                      }
                    },
                    
                    textInputAction:TextInputAction.done ,
                    onSaved: (value) =>(){},
                    decoration: InputDecoration(hintText: "Enter Last Name",
                    border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10,),
                   TextFormField(
                    controller: _textEditingController3,
                    
                    validator:  (value) {
                      if(value!.length<1){
                        return 'enter at least one characters';
                      }
                      else  {
                          return null;
                      }
                    },
                    
                    textInputAction:TextInputAction.done ,
                    onSaved: (value) => (){},
                    decoration: InputDecoration(hintText: "Enter  Age",
                    border: OutlineInputBorder()
                    ),
                  ),
                ],
              )),
          actions: <Widget>[
             ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey
            ),
            child: Text('Done'),
            onPressed: () {
              final isValid=formkey.currentState?.validate();
              if(isValid!){
                
              formkey.currentState!.save();
              Navigator.of(context).pop();
               }
              } 
          
            ),
          ],
        );
      });
    });
}

  void onselectrow(bool val, User users) async{
    setState(() {
      if(val){
      selusers.add(users);
    }
    else{
      selusers.remove(users);
    }
    });
  }

  }

