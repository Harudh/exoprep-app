import 'package:flutter/material.dart';
import 'package:root/src/features/read_paper/widgets/loading_shimmer.dart';
import 'package:root/src/models/paper_model/paper_model.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/extensions/context_extension.dart';
import 'package:root/src/features/read_paper/widgets/tab_bar.dart';
import 'package:root/src/features/read_paper/widgets/question_tile.dart';
import 'package:root/src/features/read_paper/read_paper_viewmodel.dart';

part 'read_paper_mixin.dart';

class ReadPaperView extends StatefulWidget {
  const ReadPaperView({required this.paper, super.key});

  final Paper paper;

  @override
  State<ReadPaperView> createState() => _ReadPaperViewState();
}

class _ReadPaperViewState extends State<ReadPaperView> with ReadPaperMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _readPaperViewmodel.readPaperViewState,
      builder: (context, value, child) {
        if (value.status == ViewModelStatus.loading) {
          return ReadPaperLoadingShimmer(paperName: widget.paper.name);
        }
        if (value.status == ViewModelStatus.success) {
          final subjects = _readPaperViewmodel.subjects.value;
          final allQuestions = _readPaperViewmodel.questionsData.value;

          return DefaultTabController(
            length: _readPaperViewmodel.subjects.value.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.paper.name, style: context.titleMedium),
                bottom: ReadPaperTabBar(subjects: _readPaperViewmodel.subjects.value),
              ),
              body: TabBarView(
                children: subjects.map((subject) {
                  final questionsForSubject = allQuestions.where((q) => q.topic.subject.id == subject.id).toList();

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    itemCount: questionsForSubject.length,
                    itemBuilder: (context, index) {
                      // Placeholder for your future Question Tile
                      return QuestionTile(question: questionsForSubject[index], index: index);
                    },
                  );
                }).toList(),
              ),
            ),
          );
        }
        return Center(child: Text('No Data'));
      },
    );
  }
}
