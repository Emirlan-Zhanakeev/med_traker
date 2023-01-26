import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
    /*StreamBuilder(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      return Text(data)
    }
    ),*/
              
            /*  StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData) {
                    return Expanded(
                        child:
                      ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                  var data = snapshot.data!.docs[i];
                      return Text(data['email']);
                    }
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
*/

              Text(user.uid),
              Text(user.email!),
            ],
        ),
    );
  }
}
