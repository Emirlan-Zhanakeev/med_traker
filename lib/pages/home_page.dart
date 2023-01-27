import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled1/components/action_button.dart';
import 'package:untitled1/components/habit_tile.dart';
import 'package:untitled1/components/my_alert_box.dart';
import 'package:untitled1/data/habit_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

/*  ///data structure for today's list
  List todaysHabitsList = [
    /// [habitName, habitCompleted]
    ["Vitamin D", false],
    ["Saw Palmetto", false],
  ];*/


  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  @override
  void initState() {
    ///if there is no current habit list, then it is 1st time ever opening the app
    ///then create default data
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
      }
    ///there already exists data, this is not the first time
    else {
      db.loadData();
    }

    db.updateDatabase();

    super.initState();
  }

  ///checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
  }

  ///create a new habit
  final _newHabitNameController = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  ///save new habit
  void saveNewHabit() {
    ///adding
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });

    ///close dialog box
    _newHabitNameController.clear();
    Navigator.of(context).pop();

    db.updateDatabase();
  }

  ///cancel new habit
  void cancelDialogBox() {
    _newHabitNameController.clear();

    ///close dialog box
    Navigator.of(context).pop();
  }

  ///open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  ///save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
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
              title: Text("Id:  ${user.uid}"),
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
        itemCount: db.todaysHabitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            settingsTapped: (context) => openHabitSettings(index),
            deleteTapped: (context) => deleteHabit(index),
            habitName: db.todaysHabitList[index][0],
            habitCompleted: db.todaysHabitList[index][1],
            onChanged: (value) {
              checkBoxTapped(value, index);
            },
          );
        },
      ),
    );
  }
}
