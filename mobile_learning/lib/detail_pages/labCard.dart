import 'package:flutter/material.dart';
import 'package:mobile_learning/detail_pages/labDetail.dart';

class LabCard extends StatelessWidget {
  final String labCode;
  final String labTopic;
  final String labDescription;
  final String labStartDate;
  final String labEndDate;
  final String labProgramName;

  const LabCard({
    Key? key,
    required this.labCode,
    required this.labTopic,
    required this.labDescription,
    required this.labStartDate,
    required this.labEndDate,
    required this.labProgramName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('$labCode'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LabDetailPage(
                code: labCode,
                topic: labTopic,
                description: labDescription,
                startDate: labStartDate,
                endDate: labEndDate,
                programName: labProgramName,
              ),
            ),
          );
        },
      ),
    );
  }
}
