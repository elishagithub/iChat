// import 'package:country_flags/country_flags.dart';
// import 'package:flutter/material.dart';

// class CustomISDField extends StatefulWidget {
//   @override
//   CustomISDFieldState createState() => CustomISDFieldState();
// }

// class CustomISDFieldState extends State<CustomISDField> {
//   late String _selectedCountryCode;

//   final List<Map<String, dynamic>> _countryList = [
//     {'name': 'United States', 'isoCode': '+1', 'flag': 'US'},
//     {'name': 'Canada', 'isoCode': '+1', 'flag': 'CA'},
//     {'name': 'India', 'isoCode': '+91', 'flag': 'IN'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField(
//       value: _selectedCountryCode,
//       decoration: const InputDecoration(
//         labelText: 'Country',
//       ),
//       items: _countryList.map((country) {
//         return DropdownMenuItem(
//           value: country['isoCode'],
//           child: Row(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(right: 10),
//                 child: CountryFlag.fromLanguageCode(
//                   country['flag'],
//                 ),
//               ),
//               Text('${country['name']} (${country['isoCode']})'),
//             ],
//           ),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           _selectedCountryCode = value;
//         });
//       },
//     );
//   }
// }
