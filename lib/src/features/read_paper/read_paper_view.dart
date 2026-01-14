import 'package:flutter/material.dart';
import 'package:root/src/models/paper_model/paper_model.dart';

class ReadPaperView extends StatelessWidget {
  const ReadPaperView({required this.paper, super.key});

  final Paper paper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar());
  }
}
