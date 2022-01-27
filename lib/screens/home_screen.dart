import 'package:dummy/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dummy/utils/paragraph_text.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';

import 'account_screen.dart';
import 'content_screen.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({Key? key, required this.userName}): super(key:key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  late List<bool> isSelected= [true,false]; 

  @override
  void initState() {
    super.initState();
    // getTextData();
  }

  @override
  Widget build(BuildContext context) {
    String _selectedGender = 'male';
    final TextEditingController _searchController = TextEditingController();
    
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF), // WHITE
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title:const Text('Narrator'),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_box_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context)=> AccountScreen(userName: widget.userName,))
                  );
                },
              ),
            ],
            bottom: AppBar(
              
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (text){
                      
                    },
                    decoration: const InputDecoration(
                        hintText: 'Search for Texts',
                        prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(height: 20,),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final currentText = allTexts[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context)=> ContentScreen(paragraphText:currentText,))
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding:const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  currentText.title,
                                  style:const  TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  currentText.content,
                                  style: const TextStyle(
                                    fontSize: 12, 
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(DateFormat.jm().format(DateTime.now())),
                      ],
                    ),
                  ),
                );
              },
              childCount: allTexts.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (_) => ContentScreen(paragraphText:ParagraphText('',''),)
            )
          );
        },
        child: const Icon(Icons.add),
      ) 
    );
  }
}