import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'Actions.dart';

void main() {
  final store = Store<int>(counterReducer, initialState: 0);

  runApp(MyApp(
    title: "Redux Demo",
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final String title;
  final Store<int> store;

  MyApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('tap buttons'),
                StoreConnector<int, String>(
                  converter: (store) => store.state.toString(),
                  builder: (context, count) {
                    return Text(
                      count,
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                StoreConnector<int, VoidCallback>(
                  builder: (context, callback) {
                    return IconButton(
                      onPressed: callback,
                      icon: Icon(Icons.plus_one),
                    );
                  },
                  converter: (store) {
                    return () => store.dispatch(Actions.Increment);
                  },
                ),
                StoreConnector<int, VoidCallback>(
                  builder: (context, callback) {
                    return IconButton(
                      onPressed: callback,
                      icon: Icon(Icons.exposure_neg_1),
                    );
                  },
                  converter: (store) {
                    return () => store.dispatch(Actions.Decrement);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
