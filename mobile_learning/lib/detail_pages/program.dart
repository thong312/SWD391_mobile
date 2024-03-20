import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_learning/detail_pages/labCard.dart';
import 'dart:convert';

class ProgramDetailPage extends StatelessWidget {
  final String code;
  final String name;
  final String imageUrl;
  final String description;
  final String startDate;
  final String endDate;
  final int programId;

  const ProgramDetailPage({
    Key? key,
    required this.code,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.programId,
  }) : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchLabData(int programId) async {
    const String baseUrl = 'https://stem-backend.vercel.app/api/v1/labs/lab-list/labs-in-program';
    final Uri uri = Uri.parse('$baseUrl?ProgramId=$programId');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((lab) {
        return {
          'Code': lab['Code'],
          'Image': lab['Image'],
          'Topic': lab['Topic'],
          'Description': lab['Description'],
          'StartDate': lab['StartDate'],
          'EndDate': lab['EndDate'],
          'ProgramName': lab['ProgramName'],
        };
      }).toList();
    } else {
      throw Exception('Lab not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Code: $code',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: $description',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate))}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'End Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate))}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Labs:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _fetchLabData(programId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final labData = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: labData.map((lab) => LabCard(
                            labCode: lab['Code'],
                            labImage: lab["Image"],
                            labTopic: lab['Topic'],
                            labDescription: lab['Description'],
                            labStartDate: lab['StartDate'],
                            labEndDate: lab['EndDate'],
                            labProgramName: lab['ProgramName'],
                          )).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ProgramDetailPage extends StatelessWidget {
//   final String code;
//   final String name;
//   final String imageUrl;
//   final String description;
//   final String startDate;
//   final String endDate;
//   final int programId;

//   const ProgramDetailPage({
//     Key? key,
//     required this.code,
//     required this.name,
//     required this.imageUrl,
//     required this.description,
//     required this.startDate,
//     required this.endDate,
//     required this.programId,
//   }) : super(key: key);

//   Future<List<Map<String, dynamic>>> _fetchLabData(int programId) async {
//     const String baseUrl = 'https://stem-backend.vercel.app/api/v1/labs/lab-list/labs-in-program';
//     final Uri uri = Uri.parse('$baseUrl?ProgramId=$programId');

//     final response = await http.get(uri);

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((lab) {
//         return {
//           'Code': lab['Code'],
//           'Image': lab['Image'],
//           'Topic': lab['Topic'],
//           'Description': lab['Description'],
//           'StartDate': lab['StartDate'],
//           'EndDate': lab['EndDate'],
//           'ProgramName': lab['ProgramName'],
//         };
//       }).toList();
//     } else {
//       throw Exception('Lab not found');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           name,
//           style: const TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               height: 200,
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Code: $code',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Description: $description',
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Start Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(startDate))}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'End Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate))}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Labs:',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   FutureBuilder<List<Map<String, dynamic>>>(
//                     future: _fetchLabData(programId),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Center(child: Text('Error: ${snapshot.error}'));
//                       } else {
//                         final labData = snapshot.data!;
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: labData.map((lab) => LabCard(
//                             labCode: lab['Code'],
//                             labImage: lab["Image"],
//                             labTopic: lab['Topic'],
//                             labDescription: lab['Description'],
//                             labStartDate: lab['StartDate'],
//                             labEndDate: lab['EndDate'],
//                             labProgramName: lab['ProgramName'],
//                           )).toList(),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LabCard extends StatelessWidget {
//   final String labCode;
//   final String labImage;
//   final String labTopic;
//   final String labDescription;
//   final String labStartDate;
//   final String labEndDate;
//   final String labProgramName;

//   const LabCard({
//     Key? key,
//     required this.labCode,
//     required this.labImage,
//     required this.labTopic,
//     required this.labDescription,
//     required this.labStartDate,
//     required this.labEndDate,
//     required this.labProgramName,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 150,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 image: DecorationImage(
//                   image: NetworkImage(labImage),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               labTopic,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               labDescription,
//               style: const TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Start Date: $labStartDate',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'End Date: $labEndDate',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Program: $labProgramName',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

