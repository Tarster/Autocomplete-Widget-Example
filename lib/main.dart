import 'package:flutter/material.dart';
import 'country.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Auto Complete TextField Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AutoCompleteDemo(),
    );
  }
}

class AutoCompleteDemo extends StatefulWidget {

  final String title = "AutoComplete Demo";

  @override
  _AutoCompleteDemoState createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoCompleteDemo> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Country>> key = new GlobalKey();
  List<Country> countriesName = CountryData.getCountries();

  Widget row(Country country) {
    return Container(
     
      child: 
        Text(
          country.countryName,
          style: TextStyle(fontSize: 16.0),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          searchTextField = AutoCompleteTextField<Country>(
            key: key,
            clearOnSubmit: false,
            suggestions: countriesName,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
              hintText: "Search Name",
              hintStyle: TextStyle(color: Colors.black),
            ),
            itemFilter: (item, query) {
              return item.countryName
                  .toLowerCase()
                  .startsWith(query.toLowerCase());
            },
            itemSorter: (a, b) {
              return a.countryName.compareTo(b.countryName);
            },
            itemSubmitted: (item) {
              setState(() {
                searchTextField.textField.controller.text = item.countryName;
              });
            },
            itemBuilder: (context, item) {
              // ui for the autocompelete row
              return row(item);
            },
          ),
        ],
      ),
    );
  }
}
