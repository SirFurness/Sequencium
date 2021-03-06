import 'package:flutter/material.dart';

import 'dialog.dart' as dialog;
import 'player.dart';
import 'game.dart';
import 'server.dart';
import 'join_game_dialog.dart' as join_game;
import 'host_game_dialog.dart' as host_game;
import 'grid_widget.dart' as grid_widget;
import 'winner.dart';

class LocalGame extends StatefulWidget {
  LocalGame(this.server, this.startMultiplayer);

  final server;

  final Function startMultiplayer;

  @override
  _LocalGameState createState() => _LocalGameState();
}

class _LocalGameState extends State<LocalGame> {
  Game game = Game();

  @override
  void initState() {
    _initializeState();
  }

  void _initializeState() {
    game.restart();
    setState(() {});
  }

  String _getGameOverText() {
    switch(game.getWinner()) {
      case Winner.Tie: {
        return "It was a tie!";
      }
      break;

      case Winner.A: {
        return "Player " + grid_widget.strColorForA + " won!";
      }
      break;

      case Winner.B: {
        return "Player " + grid_widget.strColorForB + " won!";
      }
      break;

      case Winner.NotOver: {
        return "The game is not over yet!";
      }
      break;
    }
  }

  String _getCurrentPlayerColorString() {
    switch(game.currentPlayer) {
      case Player.A: {
        return grid_widget.strColorForA;
      }
      break;

      case Player.B: {
        return grid_widget.strColorForB;
      }
      break;
    }

    return "";
  }

  Color _getCurrentPlayerColor() {
    switch(game.currentPlayer) {
      case Player.A: {
        return grid_widget.colorForA;
      }
      break;

      case Player.B: {
        return grid_widget.colorForB;
      }
      break;
    }

    return Colors.black;
  }

  void _onSquareTap(int row, int col) {
    game.updateGrid(row, col);
    
    setState(() {});

    if(game.isGameOver()) {
      dialog.showGameOverDialog(context, _initializeState, _getGameOverText());
    }
  }
  
  Widget _createCurrentPlayerText() {
    String colorStr = _getCurrentPlayerColorString();

    Widget text = Text(
      colorStr + "'s Turn",
      style: TextStyle(
        fontSize: 25.0,
        color: _getCurrentPlayerColor(),
      ),
    );

    return text;
  }

  Widget _createRestartButton() {
    var button = IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {dialog.showRestartDialog(context, _initializeState);},
      tooltip: "Restart Game",
    );

    return Flexible(child: button);
  }
  
  Widget _createJoinButton() {
    void submitCallback(code) {
      widget.server.joinGame(code);
      widget.startMultiplayer();
    }

    var joinButton = RaisedButton(
      child: Text("Join Game"),
      onPressed: () {
        join_game.showJoinGameDialog(context, submitCallback);
      },
    );

    return joinButton;
  }

  Widget _createHostButton() {
    var hostButton = RaisedButton(
      child: Text("Host Game"),
       onPressed: () {
        host_game.showHostGameDialog(context, widget.server, () {
          widget.startMultiplayer();
        });
      },
    );
    
    return hostButton;
  }

  Widget _createButtons() {
    var restartButton = _createRestartButton();

    var joinButton = _createJoinButton();
    var hostButton = _createHostButton();

    var row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        restartButton,
        SizedBox(width: 50),
        joinButton,
        hostButton,
      ],
    );

    return row;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _createCurrentPlayerText(),
        grid_widget.createGridWidget(game, _onSquareTap, (Player player) {return true;}),
        _createButtons(),
      ],
    );
  }
}
