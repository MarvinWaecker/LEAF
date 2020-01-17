import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/screens/edit_profile_screen.dart';
import 'package:leaf/services/auth_service.dart';
import 'package:leaf/utilities/constants.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  ProfileScreen({this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xff111e2e),
        title: Text(
          'Profil',
          style: TextStyle(
            fontFamily: 'UbuntuRegular',
            fontSize: 24,
            color: Color(0xffE6EFE9),
          ),
        ),
      ),
      backgroundColor: Color(0xff111e2e),
      body: FutureBuilder(
        future: usersRef.document(widget.userId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xff192C43),
                valueColor: AlwaysStoppedAnimation(
                  Color(0xff213a59),
                ),
              ),
            );
          }
          User user = User.fromDoc(snapshot.data);

          return ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: user.profileImageUrl.isEmpty
                          ? AssetImage('assets/images/logo.png')
                          : CachedNetworkImageProvider(user.profileImageUrl),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[],
                              )
                            ],
                          ),
                          Container(
                            width: 200.0,
                            child: FlatButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditProfileScreen(
                                    user: user,
                                  ),
                                ),
                              ),
                              color: Color(0xff0cce6b),
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.name,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 80.0,
                      child: Text(
                        user.bio,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 80.0,
                      child: Text(
                        user.music,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 80.0,
                      child: Text(
                        user.car,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 80.0,
                      child: Text('Konversationstyp: ' +
                        user.mood,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 80.0,
                      child: Text(
                        user.smoke,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 80.0,
                      child: Text(
                        user.pet,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 300.0),
              Container(
                width: 250.0,
                child: FlatButton(
                  color: Colors.red,
                  padding: EdgeInsets.all(10.0),
                  onPressed: () => AuthService.logout(),
                  child: Text(
                    'LOGOUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
