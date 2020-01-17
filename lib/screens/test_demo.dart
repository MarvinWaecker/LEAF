

/*
FutureBuilder<Demo>(
///If future is null then API will not be called as soon as the screen
///loads. This can be used to make this Future Builder dependent
///on a button click.
future: getDemoResponse(),
builder: (context, snapshot) {
switch (snapshot.connectionState) {

///when the future is null
case ConnectionState.none:
return Text(
'Press the button to fetch data',
textAlign: TextAlign.center,
);

case ConnectionState.active:

///when data is being fetched
case ConnectionState.waiting:
return CircularProgressIndicator(
valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));

case ConnectionState.done:
///task is complete with an error (eg. When you
///are offline)
if (snapshot.hasError)
return Text(
'Error:\n\n${snapshot.error}',
textAlign: TextAlign.center,
);
///task is complete with some data
return Text(
'Fetched Data:\n\n${snapshot.data.title}',
textAlign: TextAlign.center,
);
}
},
),

 */