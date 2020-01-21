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
  String _mood;
  String _smoke;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
    _music = widget.user.music;
    _car = widget.user.car;
    if (widget.user.mood == '') {
      _mood = null;
    } else {
      _mood = widget.user.mood;
    }
    if (widget.user.smoke == '') {
      _smoke = null;
    } else {
      _smoke = widget.user.smoke;
    }
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
        profileImageUrl: _profileImageUrl,
        name: _name,
        bio: _bio,
        music: _music,
        car: _car,
        mood: _mood,
        smoke: _smoke,
      );
      DatabaseService.updateUser(user);

      Navigator.pop(context);
    }
  }

  // Variables Dropdowns
  //String _mood;

  // Listen
  var _commType = [
    'Ich bin eher der ruhige Typ',
    'Je nach Laune',
    'Ich liebe es zu quatschen',
  ];
  var _smokeType = [
    'Nichtraucher',
    'Raucher',
    'Gelegenheitsraucher',
  ];

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
                    SizedBox(
                      height: 16,
                    ),
                    CircleAvatar(
                      radius: 42.5,
                      backgroundImage: widget.user.profileImageUrl.isEmpty
                          ? AssetImage('assets/images/logo.png')
                          : CachedNetworkImageProvider(
                          widget.user.profileImageUrl),
                      backgroundColor: Colors.transparent,
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

                    /// Formular -----------------------------------------------
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        initialValue: _name,
                        style: TextStyle(
                          color: Color(0xffE6EFE9),
                          fontFamily: 'UbuntuRegular',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff4171AB)),
                          ),
                          labelText: 'Name',
                        ),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please enter a valid name'
                            : null,
                        onSaved: (input) => _name = input,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        initialValue: _bio,
                        style: TextStyle(
                          color: Color(0xffE6EFE9),
                          fontFamily: 'UbuntuRegular',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff4171AB)),
                          ),
                          labelText: 'Über mich',
                        ),
                        validator: (input) => input.trim().length > 300
                            ? 'Please enter a bio less than 300 characters'
                            : null,
                        onSaved: (input) => _bio = input,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        initialValue: _music,
                        style: TextStyle(
                          color: Color(0xffE6EFE9),
                          fontFamily: 'UbuntuRegular',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff4171AB)),
                          ),
                          labelText: 'Lieblingsmusik',
                        ),
                        validator: (input) => input.trim().length > 150
                            ? 'Please enter a bio less than 150 characters'
                            : null,
                        onSaved: (input) => _music = input,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        initialValue: _car,
                        style: TextStyle(
                          color: Color(0xffE6EFE9),
                          fontFamily: 'UbuntuRegular',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff4171AB)),
                          ),
                          labelText: 'Mein Auto',
                        ),
                        validator: (input) => input.trim().length > 150
                            ? 'Please enter a bio less than 150 characters'
                            : null,
                        onSaved: (input) => _car = input,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff4171AB)),
                              ),
                              labelStyle: TextStyle(fontSize: 16),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 16.0),
                              labelText: 'Kommunikationstyp',
                            ),
                            isEmpty: _mood == null,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _mood,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _mood = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _commType.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: Color(0xffE6EFE9),
                                        fontFamily: 'UbuntuRegular',
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 10.0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff4171AB)),
                              ),
                              labelStyle: TextStyle(fontSize: 16),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 16.0),
                              labelText: 'Rauchertyp',
                            ),
                            isEmpty: _smoke == null,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _smoke,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _smoke = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _smokeType.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: Color(0xffE6EFE9),
                                        fontFamily: 'UbuntuRegular',
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      height: 32,
                    ),
                    // Sticky bitte
                    SizedBox(
                      width: double.maxFinite,
                      child: RaisedButton(
                        onPressed: _submit,
                        color: Color(0xff0cce6b),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          'ÄNDERUNGEN SPEICHERN',
                          style: TextStyle(
                            color: Color(0xff111e2e),
                            fontSize: 14,
                            fontFamily: 'UbuntuMedium',
                          ),
                        ),
                      ),
                    ),
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
