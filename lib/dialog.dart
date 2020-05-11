import 'package:flutter/material.dart';

void showGameOverDialog(BuildContext context, restart, gameOverText) {
  Widget restartButton= FlatButton(
    child: Text("Restart"),
    onPressed: () {
      restart();
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Game Over"),
    content: Text(gameOverText),
    actions: [
      restartButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}

void showRestartDialog(BuildContext context, restart) {
  Widget restartButton = FlatButton(
    child: Text("Restart"),
    onPressed: () {
      restart();
      Navigator.of(context).pop();
    },
  );

  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Restart Game"),
    content: Text("Are you sure you want to restart the game?"),
    actions: [
      cancelButton,
      restartButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}

void showHostGameDialog(BuildContext context) {
  //_getHostCode();
  String hostCode = "Fix this in the dialog file";

  AlertDialog alert = AlertDialog(
    title: Text("Host Game"),
    content: Text(hostCode),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}

void showJoinGameDialog(BuildContext context) {
  Widget input = TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: "Enter join code",
    ),
  );

  AlertDialog alert = AlertDialog(
    title: Text("Join Game"),
    content: input,
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}
