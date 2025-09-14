import 'package:flutter/material.dart';
import 'package:push_notification/entities/football.dart';

class FootballScoreCardWidgets extends StatelessWidget {
  const FootballScoreCardWidgets({super.key, required this.football});
  final Football football;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(football.team1Name.toString()),
                Text(football.team1Score.toString()),
              ],
            ),
            Text('VS'),
            Column(
              children: [
                Text(football.team2Name.toString()),
                Text(football.team2Score.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
