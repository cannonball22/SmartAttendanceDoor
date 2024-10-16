//t2 Core Packages Imports
import 'package:flutter/material.dart';
import 'package:smart_attendance_door/features/users%20management/presentation/pages/search_existing_users_screen.dart';

import 'create_new_user_screen.dart';

//t2 Dependencies Imports
//t3 Services
//t3 Models
//t1 Exports

class AddNewUserScreen extends StatefulWidget {
  //SECTION - Widget Arguments
  //!SECTION
  //
  const AddNewUserScreen({
    super.key,
  });

  @override
  State<AddNewUserScreen> createState() => _AddNewUserScreenState();
}

class _AddNewUserScreenState extends State<AddNewUserScreen> {
  //
  //SECTION - State Variables
  //t2 --Controllers
  //t2 --Controllers
  //
  //t2 --State
  //t2 --State
  //
  //t2 --Constants
  //t2 --Constants
  //!SECTION

  @override
  void initState() {
    super.initState();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --Controllers & Listeners
    //t2 --Controllers & Listeners
    //
    //t2 --State
    //t2 --State
    //
    //t2 --Late & Async Initializers
    //t2 --Late & Async Initializers
    //!SECTION
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    //SECTION - State Variables initializations & Listeners
    //t2 --State
    //t2 --State
    //!SECTION
  }

  //SECTION - Stateless functions
  //!SECTION

  //SECTION - Action Callbacks
  //!SECTION

  @override
  Widget build(BuildContext context) {
    //SECTION - Build Setup
    //t2 -Values
    //double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    //t2 -Values
    //
    //t2 -Widgets
    //t2 -Widgets
    //!SECTION

    //SECTION - Build Return
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add New Student",
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Search Existing'),
              Tab(text: 'Create New One'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SearchExistingUser(),
            CreateNewUserScreen(),
          ],
        ),
      ),
    );
    //!SECTION
  }

  @override
  void dispose() {
    //SECTION - Disposable variables
    //!SECTION
    super.dispose();
  }
}
