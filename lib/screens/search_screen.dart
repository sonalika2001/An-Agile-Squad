import 'package:an_agile_squad/backend/firebase_repository.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/utils/constants.dart';
import 'package:an_agile_squad/widgets/custom_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'chat screens/chat_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

//for instant search results, we query all the data and save it in a list.
class _SearchScreenState extends State<SearchScreen> {
  FirebaseRepository _repository = FirebaseRepository();

  List<Client> userList;
  String query = "";
  TextEditingController searchController =
      TextEditingController(); //for text control in the textfield

  @override
  void initState() {
    
    super.initState();

    _repository.getCurrentUser().then((User user) {
      _repository.fetchAllUsers(user).then((List<Client> list) {
        setState(() {
          userList = list;
        });
      });
    });
  }

//creating a customised app bar with a gradient backdrop
  searchAppBar(BuildContext context) {
    return GradientAppBar(
      backgroundColorStart: kgradientColorStart,
      backgroundColorEnd: kgradientColorEnd,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: kblackColor,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) =>
                      searchController
                          .clear()); //to handle exception thrown when user clears textfield
                },
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color(0x88ffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildSuggestions(String query) {
    //checking if user has typed anything, if yes, then search for results
    final List<Client> suggestionList = query.isEmpty
        ? []
        : userList.where((Client user) {
            String _getUsername = user.username.toLowerCase();
            String _query = query.toLowerCase();
            String _getName = user.name.toLowerCase();
            bool matchesUsername = _getUsername.contains(_query);
            bool matchesName = _getName.contains(_query);

            return (matchesUsername ||
                matchesName); //returns data if user's name or username, either match the query
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: ((context, index) {
        Client searchedUser = Client(
            uid: suggestionList[index].uid,
            profilePhoto: suggestionList[index].profilePhoto,
            name: suggestionList[index].name,
            username: suggestionList[index].username);

        return CustomTile(
          mini: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=> ChatScreen(
                receiver: searchedUser,
              )),
            );
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(searchedUser.profilePhoto),
            backgroundColor: Colors.grey,
          ),
          title: Text(
            searchedUser.username,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            searchedUser.name,
            style: TextStyle(color: kgreyColor),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblackColor,
      appBar: searchAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildSuggestions(query),
      ),
    );
  }
}
