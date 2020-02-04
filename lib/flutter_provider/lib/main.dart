import 'package:flutter/material.dart';
import 'package:flutter_slider/flutter_provider/lib/provider/home_notifier.dart';
import 'package:flutter_slider/flutter_provider/lib/screen/detail.dart';
import 'package:flutter_slider/flutter_provider/lib/service/api.dart';
import 'package:flutter_slider/flutter_provider/lib/service/navigator_service.dart';
import 'package:flutter_slider/flutter_provider/lib/utility/route_constants.dart';
import 'package:provider/provider.dart';
import 'screen/home.dart';

class FlutterProvider extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechCorner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'FuturaPT',
        primarySwatch: Colors.red,
      ),
      navigatorKey: Provider.of<NavigatorService>(context).navigatorKey,
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        switch(settings.name) {
          case RouteConstants.home: {
            return MaterialPageRoute(builder: (ctx) => HomeWidget());
          }
          case RouteConstants.details: {
            return MaterialPageRoute(builder: (ctx) => DetailWidget(arguments));
          }
          default: throw new Exception("route not found!");
        }
      },
      home: MyHomePage(title: 'Discover'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _onItemTapped(int index) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: buildHomeContainer(),
        bottomNavigationBar: _buildBottomBar());
  }

  _buildBottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Cart'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          title: Text('Store'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Account'),
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.red[800],
      unselectedItemColor: Colors.grey[400],
      onTap: _onItemTapped,
    );
  }

  Container buildHomeContainer() {
    return Container(
      color: Colors.white,
      child: ChangeNotifierProvider<HomeNotifier>(
        create: (ctx) => HomeNotifier(
          navigatorService: Provider.of<NavigatorService>(ctx, listen: false),
          api: Provider.of<ApiProvider>(ctx, listen: false),
        ),
        child: HomeWidget(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(widget.title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 32,
          )),
      actions: <Widget>[
        IconButton(
          color: Colors.black,
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          color: Colors.black,
          icon: Icon(Icons.notifications_none),
          onPressed: () {},
        ),
      ],
    );
  }
}
