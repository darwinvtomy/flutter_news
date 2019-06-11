import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        {
          return MaterialPageRoute(builder: (context) {
            final storiesBLoc = StoriesProvider.of(context);
            storiesBLoc.fetchTopIds();

            return NewsList();
          });
        }
        break;
      default:
        {
          print('Default is Initiated ');
          return MaterialPageRoute(builder: (context) {
            final commentsBloc = CommentsProvider.of(context);
            //Extract the Item Id from Settings.name
            final itemId = int.parse(settings.name.replaceFirst('/', ''));
            commentsBloc.fetchItemWithComments(itemId);

            //And pass into NewsDetail
            // A fantastic location to do some initilization
            return NewsDetail(
              itemId: itemId,
            );
          });
        }
    }
  }
}
