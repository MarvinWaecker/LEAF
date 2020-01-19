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

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {

  // Variables
  TabController _tabController;
  int selectedRadioComm;
  int selectedRadioPay;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
    selectedRadioComm = 1;
    selectedRadioPay = 1;
  }

  setSelectedRadioComm(int val) {
    setState(() {
      selectedRadioComm = val;
    });
  }
  setSelectedRadioPay(int val) {
    setState(() {
      selectedRadioPay = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
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
          return Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                      offset: Offset(
                        0, // Move to right 10  horizontally
                        4.0, // Move to bottom 5 Vertically
                      ),
                    ),
                  ],
                ),
                width: double.infinity,
                child: DefaultTabController(
                  length: 2,
                  child: Container(
                    color: Color(0xff111e2e),
                    child: TabBar(
                        controller: _tabController,
                        labelColor: Color(0xffE6EFE9),
                        unselectedLabelColor: Color(0xffAAAEB2),
                        indicatorColor: Color(0xff0cce6b),
                        tabs: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8, top: 16),
                            child: Text(
                              'Öffentlich',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'UbuntuLight',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8, top: 16),
                            child: Text(
                              'Einstellungen',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'UbuntuLight',
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      ListView(
                        physics: new BouncingScrollPhysics(),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 42.5,
                                  backgroundImage: user.profileImageUrl.isEmpty
                                      ? AssetImage(
                                      'assets/images/Profilbild_Paul.png')
                                      : CachedNetworkImageProvider(
                                      user.profileImageUrl),
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  child: Text(
                                    user.name,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'UbuntuLight',
                                      fontSize: 20,
                                      color: Color(0xffE6EFE9),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  child: Container(
                                    child: RaisedButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => EditProfileScreen(
                                            user: user,
                                          ),
                                        ),
                                      ),
                                      color: Color(0xff111e2e),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Color(0xff0cce6b)),
                                        borderRadius:
                                        new BorderRadius.circular(18.0),
                                      ),
                                      child: Text(
                                        'PROFIL BEARBEITEN',
                                        style: TextStyle(
                                          color: Color(0xff0cce6b),
                                          fontSize: 14,
                                          fontFamily: 'UbuntuMedium',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 32, left: 16, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'Über mich',
                                    style: TextStyle(
                                      fontFamily: 'UbuntuLight',
                                      fontSize: 16,
                                      color: Color(0xffE6EFE9),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  child: Text(
                                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea dsfhhj hdjsaf.',
                                    // user.bio
                                    style: TextStyle(
                                      fontFamily: 'UbuntuLight',
                                      fontSize: 14,
                                      color: Color(0xffE6EFE9),
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  child: Text(
                                    'Fahrerinfos',
                                    style: TextStyle(
                                      fontFamily: 'UbuntuLight',
                                      fontSize: 16,
                                      color: Color(0xffE6EFE9),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  child: Text(
                                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea dsfhhj hdjsaf.',
                                    // user.bio
                                    style: TextStyle(
                                      fontFamily: 'UbuntuLight',
                                      fontSize: 14,
                                      color: Color(0xffE6EFE9),
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.0),
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: SizedBox(
                              child: FlatButton(
                                onPressed: () => AuthService.logout(),
                                child: Text(
                                  "AUSLOGGEN",
                                  style: TextStyle(
                                    color: Color(0xffe8b641),
                                    fontFamily: 'UbuntuMedium',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                        child: ListView(
                          physics: new BouncingScrollPhysics(),
                          children: <Widget>[
                            Text(
                              'Kommunikation',
                              style: TextStyle(
                                color: Color(0xffE6EFE9),
                                fontFamily: 'UbuntuLight',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              'Wähle aus, wie du mit Mitfahrern kommunizieren möchtest.',
                              style: TextStyle(
                                color: Color(0xffE6EFE9),
                                fontFamily: 'UbuntuLight',
                                fontSize: 14,
                                height: 1.3,
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: selectedRadioComm,
                                      activeColor: Color(0xff0cce6b),
                                      onChanged: (val) {
                                        setSelectedRadioComm(val);
                                      },
                                    ),
                                    Text(
                                      'E-Mail',
                                      style: TextStyle(
                                        color: Color(0xffE6EFE9),
                                        fontFamily: 'UbuntuLight',
                                        fontSize: 14,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 2,
                                      groupValue: selectedRadioComm,
                                      activeColor: Color(0xff0cce6b),
                                      onChanged: (val) {
                                        setSelectedRadioComm(val);
                                      },
                                    ),
                                    Text(
                                      'Handy',
                                      style: TextStyle(
                                        color: Color(0xffE6EFE9),
                                        fontFamily: 'UbuntuLight',
                                        fontSize: 14,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 24,),
                            Text(
                              'Bezahlung',
                              style: TextStyle(
                                color: Color(0xffE6EFE9),
                                fontFamily: 'UbuntuLight',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              'Wähle aus, wie du von deinen Mitfahrern bezahlt werden möchtest',
                              style: TextStyle(
                                color: Color(0xffE6EFE9),
                                fontFamily: 'UbuntuLight',
                                fontSize: 14,
                                height: 1.3,
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: selectedRadioPay,
                                      activeColor: Color(0xff0cce6b),
                                      onChanged: (val) {
                                        setSelectedRadioPay(val);
                                      },
                                    ),
                                    Text(
                                      'Bar',
                                      style: TextStyle(
                                        color: Color(0xffE6EFE9),
                                        fontFamily: 'UbuntuLight',
                                        fontSize: 14,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 2,
                                      groupValue: selectedRadioPay,
                                      activeColor: Color(0xff0cce6b),
                                      onChanged: (val) {
                                        setSelectedRadioPay(val);
                                      },
                                    ),
                                    Text(
                                      'PayPal',
                                      style: TextStyle(
                                        color: Color(0xffE6EFE9),
                                        fontFamily: 'UbuntuLight',
                                        fontSize: 14,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 48),
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Color(0xffE6EFE9),
                                      fontFamily: 'UbuntuRegular',
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                                      labelText: 'E-Mail',
                                      labelStyle: TextStyle(
                                        color: Color(0xff4171AB),
                                        fontFamily: 'UbuntuRegular',
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff4171AB)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xff0cce6b)),
                                      ),
                                    ),
                                    validator: (input) => !input.contains('@')
                                        ? 'Please enter a valid email'
                                        : null,
                                    onSaved: (input) {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32,),
                            Row(
                              children: <Widget>[
                                Text(
                                  'FAQ',
                                  style: TextStyle(
                                    color: Color(0xffE6EFE9),
                                    fontFamily: 'UbuntuLight',
                                    fontSize: 16,
                                    height: 1.3,
                                  ),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                )
                              ],
                            ),
                            SizedBox(height: 32,),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Über das LEAF Team',
                                  style: TextStyle(
                                    color: Color(0xffE6EFE9),
                                    fontFamily: 'UbuntuLight',
                                    fontSize: 16,
                                    height: 1.3,
                                  ),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                )
                              ],
                            ),
                            SizedBox(height: 32.0),
                            Padding(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: SizedBox(
                                child: FlatButton(
                                  onPressed: () => AuthService.logout(),
                                  child: Text(
                                    "AUSLOGGEN",
                                    style: TextStyle(
                                      color: Color(0xffe8b641),
                                      fontFamily: 'UbuntuMedium',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
