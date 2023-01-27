import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/components/action_button.dart';
import 'package:untitled1/components/habit_tile.dart';
import 'package:untitled1/components/new_habit_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  ///data structure for today's list
  List todaysHabitsList = [
    /// [habitName, habitCompleted]
    ["Vitamin D", false],
    ["Saw Palmetto", false],
    ["Groprinosin", false],
  ];

  ///checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitsList[index][1] = value;
    });
  }

  ///create a new habit
  final _newHabitNameController = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return EnterNewHabitBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelNewHabit,
        );
      },
    );
  }

  ///save new habit
  void saveNewHabit() {

  }

  ///cancel new habit
  void cancelNewHabit() {
    Navigator.of(context).pop();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: creatingActionButton(
        onPressed: () {
          createNewHabit();
        },
      ),

      /// Profile
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.deepPurple[200],
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text("E-mail:  ${user.email!}"),
            ),
            ListTile(
              onTap: () {},
              title: Text("Id:  ${user.uid!}"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
        itemCount: todaysHabitsList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: todaysHabitsList[index][0],
            habitCompleted: todaysHabitsList[index][1],
            onChanged: (value) {
              checkBoxTapped(value, index);
            },
          );
        },
      ),
    );
  }
}
