import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:push_notification/entities/football.dart';
import 'package:push_notification/widgets/football_score_card_widgets.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Football> matchList = [];

  Future<void> _getFootballMatches() async {
    matchList.clear();
    final QuerySnapshot result = await firebaseFirestore
        .collection('football')
        .get();
    for (QueryDocumentSnapshot doc in result.docs) {
      matchList.add(
        Football(
          matchName: doc.id,
          team1Name: doc.get('team1Name'),
          team1Score: doc.get('team1'),
          team2Name: doc.get('team2Name'),
          team2Score: doc.get('team2'),
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getFootballMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Match Screen")),
      body: StreamBuilder(
        stream: firebaseFirestore.collection('football').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No matches available'));
          }
          matchList.clear();
          for (QueryDocumentSnapshot doc in snapshot.data?.docs ?? []) {
            matchList.add(
              Football(
                matchName: doc.id,
                team1Name: doc.get('team1Name'),
                team1Score: doc.get('team1'),
                team2Name: doc.get('team2Name'),
                team2Score: doc.get('team2'),
              ),
            );
          }
          return ListView.builder(
            itemCount: matchList.length,
            itemBuilder: (context, index) {
              return FootballScoreCardWidgets(football: matchList[index]);
            },
          );
        },
      ),
    );
  }
}
