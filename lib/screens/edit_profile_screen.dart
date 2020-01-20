import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/services/database_service.dart';
import 'package:leaf/services/storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  File _profileImage;
  String _name = '';
  String _bio = '';
  String _music = '';
  String _car = '';
  String mood = 'One';
  String dropdown = 'Ich bin eher der ruhige Typ';
  String dropdownValue = 'One';

  List<String> moods = [
    'Ich bin eher der ruhige Typ',
    'Meine Gesprächigkeit hängt von meiner Laune ab',
    'Ich liebe es zu quatschen',
  ];

  /*
  List<DropdownMenuItem> moodsDrop = items: [
    DropdownMenuItem(
        value: '1', child: Text(
  'Ich bin eher der ruhige Typ'
      ),
        ),
  DropdownMenuItem(
      value: '2', child: Text(
  'Meine Gesprächigkeit hängt von meiner Laune ab',

  ),
      ),
  DropdownMenuItem(
       value: '3', child: Text(    'Ich liebe es zu quatschen',
  ),
      ),
  ];

   */
  String smoke = null;
  List<String> smokes = [
    'Im Auto darf nicht geraucht werden',
    'Manchmal erlaube ich Rauchen',
    'Zigarettenrauch stört mich nicht',
    'Bitte noch festlegen'
  ];
  String pet = null;
  List<String> pets = [
    'Sorry, ich nehme keine Haustiere mit',
    'Kommt auf das Tier an',
    'Haustiere sind erlaubt'
  ];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
    _music = widget.user.music;
    _car = widget.user.car;
    mood = widget.user.mood;
    smoke = widget.user.smoke;
    pet = widget.user.pet;
  }

  _handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayProfileImage() {
    if (_profileImage == null) {
      if (widget.user.profileImageUrl.isEmpty) {
        return AssetImage('assets/images/Profilbild_Paul.png');
      } else {
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    } else {
      return FileImage(_profileImage);
    }
  }

  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      String _profileImageUrl = '';

      if (_profileImage == null) {
        _profileImageUrl == widget.user.profileImageUrl;
      } else {
        _profileImageUrl = await StorageService.uploadUserProfileImage(
            widget.user.profileImageUrl, _profileImage);
      }
      User user = User(
        id: widget.user.id,
        name: _name,
        profileImageUrl: _profileImageUrl,
        bio: _bio,
        music: _music,
        mood: mood,
        smoke: smoke,
        pet: pet,
      );
      DatabaseService.updateUser(user);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff111e2e),
          automaticallyImplyLeading: true,
          title: Text(
            'Profil bearbeiten',
            style: TextStyle(
              fontFamily: 'UbuntuRegular',
              fontSize: 24,
              color: Color(0xffE6EFE9),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Color(0xffe8b641),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          physics: new BouncingScrollPhysics(),
          children: <Widget>[
            _isLoading
                ? LinearProgressIndicator(
                    backgroundColor: Color(0xff192C43),
                    valueColor: AlwaysStoppedAnimation(Color(0xff213a59)),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 42.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: _displayProfileImage(),
                    ),
                    FlatButton(
                      onPressed: _handleImageFromGallery,
                      child: Text(
                        'Profilbild ändern',
                        style: TextStyle(
                          fontFamily: 'UbuntuMedium',
                          fontSize: 16,
                          color: Color(0xff0cce6b),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      initialValue: _name,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (input) => input.trim().isEmpty
                          ? 'Please enter a valid name'
                          : null,
                      onSaved: (input) => _name = input,
                    ),
                    TextFormField(
                      initialValue: _bio,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: 'Über mich',
                      ),
                      validator: (input) => input.trim().length > 300
                          ? 'Please enter a bio less than 300 characters'
                          : null,
                      onSaved: (input) => _bio = input,
                    ),
                    TextFormField(
                      initialValue: _music,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: 'Lieblingsmusik',
                      ),
                      validator: (input) => input.trim().length > 150
                          ? 'Please enter a bio less than 150 characters'
                          : null,
                      onSaved: (input) => _music = input,
                    ),
                    TextFormField(
                      initialValue: _car,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: 'Mein Auto',
                      ),
                      validator: (input) => input.trim().length > 150
                          ? 'Please enter a bio less than 150 characters'
                          : null,
                      onSaved: (input) => _car = input,
                    ),

                    /*
                    DropdownButtonFormField(
                      hint: Text(
                        'Redseligkeit',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.people,
                          size: 30.0,
                        ),
                      ),
                      value: mood,
                      onChanged: (newValue) {
                        setState(() {
                          mood = newValue;
                        });
                      },
                      items: moods.map((talk) {
                        return DropdownMenuItem(
                          child: new Text(talk),
                          value: talk,
                        );
                      }).toList(),
                    ),

                     */

                    Row(
                      children: <Widget>[
                        /*
                        DropdownButton<String>(
                          value: dropdown,
                          hint: Text(
                            'Redseligkeit',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdown = newValue;
                            });
                          },
                          items: <String>[
                            'Ich bin eher der ruhige Typ',
                            'Meine Gesprächigkeit hängt von meiner Laune ab',
                            'Ich liebe es zu quatschen',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                         */
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['One', 'Two', 'Free', 'Four']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        /*
                        DropdownButton<String>(
                          value: mood,
                          hint: Text(
                            'Redseligkeit',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          items: moods.map((talk) {
                            return DropdownMenuItem(
                              child: new Text(talk),
                              value: talk,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              mood = newValue;
                            });
                          },
                          isExpanded: true,
                        ),

                         */
                      ],
                    ),

/*
                    DropdownButtonFormField(
                      hint: Text(
                        'Rauchen',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.smoke_free,
                          size: 30.0,
                        ),
                      ),
                      value: smoke,
                      onChanged: (newValue) {
                        setState(() {
                          smoke = newValue;
                        });
                      },
                      items: smokes.map((smoke) {
                        return DropdownMenuItem(
                          child: new Text(smoke),
                          value: smoke,
                        );
                      }).toList(),
                    ),
                    DropdownButtonFormField(
                      hint: Text(
                        'Haustiere',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.pets,
                          size: 30.0,
                        ),
                      ),
                      value: pet,
                      onChanged: (newValue) {
                        setState(() {
                          pet = newValue;
                        });
                      },
                      items: pets.map((pet) {
                        return DropdownMenuItem(
                          child: new Text(pet),
                          value: pet,
                        );
                      }).toList(),
                    ),
                     */

                    DropdownButton<String>(
                      items: [
                        DropdownMenuItem<String>(
                          value: "1",
                          child: Text(
                            "First",
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "2",
                          child: Text(
                            "Second",
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        print("value: $value");
                      },
                      hint: Text(
                        "",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    // Sticky bitte
                    Container(
                      margin: EdgeInsets.all(40.0),
                      height: 40.0,
                      width: 250.0,
                      child: FlatButton(
                        onPressed: _submit,
                        color: Color(0xff0cce6b),
                        child: Text(
                          'Save Profile',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
