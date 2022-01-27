import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<ParagraphText> allTexts= [
  ParagraphText(
    'William',
    'William is a good boy' 
  ),
  ParagraphText(
    'Elon Musk',
    'Elon is a good boy' 
  ),
  ParagraphText(
    'Albert Einstein',
    'Albert is a good boy' 
  ),
  ParagraphText(
    'William Einstein',
    'Albert is a good boy' 
  ),
  ParagraphText(
    'James Einstein',
    'Albert is a good boy' 
  ),
  ParagraphText(
    'Jacob Einstein',
    'Albert is a good boy' 
  ),  
  ParagraphText(
    'Albert William',
    'Albert is a good boy' 
  ),
];
late int user_id;

class ParagraphText {
  late String title;
  late String content;

  ParagraphText(
    this.title, 
    this.content
  );

  // duplicate add is possible (needs some work here)
  void addToAll() async{
    allTexts.add(
      ParagraphText(title,content)
    );
    const url = 'http://127.0.0.1:5000/add_data';
    http.Response response =await http.post(url, body: json.encode({
      'title':title,
      'content':content,
      'user_id':user_id
    })
    ); 
  }
  void delete() async{
    allTexts.remove(this);
    print (this.content);
    const url = 'http://127.0.0.1:5000/delete_data';
    http.Response response =await http.post(url, body: json.encode({
      'title':title,
      'content':content,
      'user_id':user_id,
      })
    );
  }
}

void getTextData() async{
  const url = 'http://127.0.0.1:5000/get_data';
  await http.post(url, body:json.encode({
    'user_id': 1
  })).then((response){
    final decoded = json.decode(response.body) as Map<String,dynamic>;
    final newdecoded= decoded['json_list'];
    for (var i=0;i<newdecoded.length;i++){
      final p = ParagraphText(
        newdecoded[i]['title'],
        newdecoded[i]['content'],
      );
      allTexts.add(p);
    }
  });
}

ParagraphText getFromTitle(String title){
  for (var i=0; i<allTexts.length;i++){
    if (allTexts[i].title==title){
      return allTexts[i];
    }
  }
  return ParagraphText('','');
}