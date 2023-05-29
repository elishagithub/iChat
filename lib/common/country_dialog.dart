import 'package:flutter/material.dart';

import '../models/country.dart';

class CountryDialog extends StatefulWidget {
  final List<Country>? countries;
  final Function(Country)? onCountrySelected;

  const CountryDialog({super.key, this.countries, this.onCountrySelected});

  @override
  CountryDialogState createState() => CountryDialogState();
}

class CountryDialogState extends State<CountryDialog> {
  List<Country> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _filteredCountries = List.of(widget.countries!);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16.0, bottom: 16, left: 32, right: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _filteredCountries = widget.countries!
                      .where((country) =>
                          country.name!
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          country.code!.contains(value))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                hintText: "Search country name or dial code",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: _filteredCountries.length,
                itemBuilder: (BuildContext context, int index) {
                  Country country = _filteredCountries[index];
                  return ListTile(
                    title: Text(country.name!),
                    trailing: Text(country.code!),
                    onTap: () {
                      widget.onCountrySelected!(country);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
