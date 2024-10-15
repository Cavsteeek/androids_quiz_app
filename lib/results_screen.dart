import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers, required this.onRestartQuiz});
  final List<String> chosenAnswers;
  final VoidCallback onRestartQuiz;

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
            Padding(
              padding: const EdgeInsets.only(top: 50), // Adjust the top padding
              child: Text(
                "You have answered $numCorrectQuestions correctly out of $numTotalQuestions questions",
                style: const TextStyle(
                  fontSize: 24, // Larger font size
                  fontWeight: FontWeight.bold, // Bold for better emphasis
                  color: Colors.black87, // Dark refined color
                ),
                textAlign: TextAlign.center, // Center align the text
              ),
            ),
            const SizedBox(height: 20), // Add extra spacing below the text

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
              onPressed: onRestartQuiz, // Call the parent callback to restart quiz
              child: const Text(
                "Restart Quiz",
                // style: TextStyle(color: Colors.white),
                  style: const TextStyle(
                    fontSize: 24, // Larger font size
                    fontWeight: FontWeight.bold, // Bold for better emphasis
                    color: Colors.black87, // Dark refined color
                  ),
                  textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
