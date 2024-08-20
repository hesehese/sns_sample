import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'next_page.dart';
import 'post.dart';
import 'update_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

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
  List<Post> posts = [];

  @override
  void initState(){
    super.initState();
    _fetchFirebaseDate();
  }


  Future _fetchFirebaseDate() async {
    print('hello00');
    await FirebaseFirestore.instance.collection("new").orderBy('createdAt', descending: true).get().then((event) {
      final docs = event.docs;
      setState(() {
        posts = docs.map((doc){
          final data = doc.data();
          final id = doc.id;
          final text = data['text'];
          final createdAt = data['createdAt'].toString();
          final updatedAt = data['updatedAt']?.toString();
          print('hello1');
          print(createdAt);
          return Post(id: id, text: text, createdAt: createdAt, updatedAt: updatedAt,);
        },
        ).toList();
        print('hello2');
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(children: posts.map((post) => InkWell(
            onTap: () async {
              await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdatePage(post),
                  ),
              );
              await _fetchFirebaseDate();
            },
            child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                Icon(
                    Icons.account_circle,
                    size: 48,
                ),
                Text(
                    post.text,
                    style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        )).toList(),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
              await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddPage(),
              ),
            );
              await _fetchFirebaseDate();
          },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
