import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary/questions_summer.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers});
  final List<String> chosenAnswers;

  // Method to get summary data
  List<Map<String, Object>> getSummaryData() {
    List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i],
        },
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You have answered $numCorrectQuestions correctly out of $numTotalQuestions questions",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 30,
            ),
            // Display the summary of questions with icons
            Expanded(
              child: ListView.builder(
                itemCount: summaryData.length,
                itemBuilder: (context, index) {
                  final data = summaryData[index];
                  final bool isCorrect =
                      data['user_answer'] == data['correct_answer'];

                  return ListTile(
                    leading: Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                    title: Text(
                      data['question'] as String,
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      "Your answer: ${data['user_answer']} \nCorrect answer: ${data['correct_answer']}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Button to restart the quiz
            TextButton(
              onPressed: () {
                // Logic to restart the quiz can be implemented here
              },
              child: const Text(
                "Restart Quiz",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
