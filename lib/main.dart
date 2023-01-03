import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

void main() => runApp( MyApp());

List _elements = [
  {'id':01,'msg': 'hey john','isMe':true, 'day': ' yesterday'},
  {'id':02,'msg': 'hey dhuruv', 'isMe':false,'day': ' yesterday'},
  {'id':03,'msg': 'Shall we meet tomorrow?','isMe':true, 'day': ' yesterday'},
  {'id':04,'msg': 'why not?', 'isMe':false,'day': ' yesterday'},
  {'id':05,'msg': 'hey john', 'isMe':true,'day': ' today'},
  {'id':06,'msg': 'hey dhuruv','isMe':false, 'day': ' today'},
  {'id':07,'msg': 'reached?', 'isMe':true,'day': ' today'},
  {'id':08,'msg': 'yep', 'isMe':false,'day': ' today'},

];

class MyApp extends StatelessWidget {

  static const styleSomebody = BubbleStyle(
    nip: BubbleNip.leftCenter,
    color: Colors.white,
    borderColor: Colors.teal,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );

  static const styleMe = BubbleStyle(
    nip: BubbleNip.rightCenter,
    color: Color.fromARGB(255, 225, 255, 199),
    borderColor: Colors.teal,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.topRight,

  );
  static const styleSearch = BubbleStyle(
    nip: BubbleNip.no,
    color: Color.fromARGB(255, 225, 255, 199),
    borderColor: Colors.tealAccent,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.center,

  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(styleMe: styleMe, styleSomebody: styleSomebody),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.styleMe,
    required this.styleSomebody,
  }) : super(key: key);

  final BubbleStyle styleMe;
  final BubbleStyle styleSomebody;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false;
  bool isEmp = false;
List <dynamic> lastList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching?TextFormField(
          onChanged: (value) {
            setState(() {
              lastList.clear();
              for(var i in _elements){

                if (i['msg'].contains(value.toLowerCase())){
                  lastList.add(i['msg']);
                }
                if (i['msg']==''){
                 setState(() {
                   isEmp = true;
                 });
                }


              }
              setState(() {
                lastList;
              });
            });
          },
        ): Text('Grouped List View Example'),
        actions: [
          IconButton(onPressed: () {
            setState(() {
              isSearching = true;
            });

          }, icon: Icon(isSearching?Icons.clear_all_rounded:Icons.search))
        ],
      ),
      body: isSearching? Container(
        child:isEmp?Container(child: SizedBox(height: 400),): Column(
          children: lastList.map((e) => Bubble(child: Text(e),
          style: MyApp.styleSearch,)).toList(),
        ),
      )



          : GroupedListView<dynamic, String>(
        elements: _elements,
        groupBy: (element) => element['day'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1['msg'].compareTo(item2['msg']),
        order: GroupedListOrder.ASC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        itemBuilder: (c, element) {
          return  Bubble(
            style:element['isMe']?widget.styleMe: widget.styleSomebody,
            child: Text(
                element['msg']),
          );
        },
      ),
    );
  }
}

