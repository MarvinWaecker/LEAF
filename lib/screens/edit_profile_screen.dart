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
  String mood = null;
  List<String> moods = [
    'Ich bin eher der ruhige Typ',
    'Meine Gesprächigkeit hängt von meiner Laune ab',
    'Ich liebe es zu quatschen',
  ];
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
        return AssetImage('assets/images/logo.png');
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
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xffE6EFE9),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading
                ? LinearProgressIndicator(
                    backgroundColor: Color(0xff192C43),
                    valueColor: AlwaysStoppedAnimation(Color(0xff213a59)),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: _displayProfileImage(),
                    ),
                    FlatButton(
                      onPressed: _handleImageFromGallery,
                      child: Text(
                        'Change Profile Picture',
                        style:
                            TextStyle(color: Color(0xff0cce6b), fontSize: 16.0),
                      ),
                    ),
                    TextFormField(
                      initialValue: _name,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          size: 30.0,
                        ),
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
                        icon: Icon(
                          Icons.book,
                          size: 30.0,
                        ),
                        labelText: 'Bio',
                      ),
                      validator: (input) => input.trim().length > 150
                          ? 'Please enter a bio less than 150 characters'
                          : null,
                      onSaved: (input) => _bio = input,
                    ),
                    TextFormField(
                      initialValue: _music,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.library_music,
                          size: 30.0,
                        ),
                        labelText: 'Favorite Music',
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
                        icon: Icon(
                          Icons.directions_car,
                          size: 30.0,
                        ),
                        labelText: 'Automodell',
                      ),
                      validator: (input) => input.trim().length > 150
                          ? 'Please enter a bio less than 150 characters'
                          : null,
                      onSaved: (input) => _car = input,
                    ),

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




/*
                   Row(
                     children: <Widget>[
                       Icon(Icons.people, size: 10.0,),
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
                            onChanged: (newValue){
                              setState(() {
                                mood = newValue;
                              });
                            },
                            isExpanded: true,
                          ),
                     ],
                   ),


 */




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
