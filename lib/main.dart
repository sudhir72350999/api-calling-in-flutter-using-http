import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_api_calling/GetSampleData.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<GetSampleData>? apiList ;
  @override
  void initState() {
    super.initState();
    getApiData();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          if(apiList != null)
          getList()
        ],

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

      ),
    );
  }


  Widget getList(){

    return Expanded(
      child: ListView.builder(
        itemCount: apiList!.length,
          itemBuilder:(BuildContext context, int index){
        return Card(
          elevation: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: Text("name  ${apiList![index].name} ", style: TextStyle(fontSize: 20),),

                ),


              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Text("email ${apiList![index].email} ", style: TextStyle(fontSize: 30),),

              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Text("body ${apiList![index].body} ", style: TextStyle(fontSize: 20),),

              )

            ],

          ),
        );

      }),
    );


  }

  Future<void> getApiData()async {
    String path = "https://jsonplaceholder.typicode.com/comments";

    var result = await http.get(Uri.parse(path));

    apiList = jsonDecode(result.body).map((item) => GetSampleData.fromJson(item)).toList()
    .cast<GetSampleData>();
    setState(() {

    });

    // print(result.body);


  }


}
