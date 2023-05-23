import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/bloc/bloc.dart';
import 'package:test_flutter/detail_screen.dart';
import 'bloc/comment_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CommentBloc commentBloc = CommentBloc();
  late ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentBloc.add(FetchEvent());
    scrollController = ScrollController();
    scrollController.addListener(_loadMoreData);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<CommentBloc, CommentState>(
            bloc: commentBloc,
            builder: (context, state) {
              if (state is CommentLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CommentSuccess) {
                if (state.listComment.isEmpty) {
                  return const Center(child: Text('Empty comments !'));
                }
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        if (index < state.listComment.length) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const DetailScreen(),
                                          settings: RouteSettings(
                                              arguments:
                                                  state.listComment[index].id)))
                                  .then(_refreshData);
                            },
                            child: ListTile(
                              leading:
                                  Text(state.listComment[index].id.toString()),
                              title: Text(state.listComment[index].body),
                              subtitle: Text(
                                  state.listComment[index].email.toString()),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      itemCount: state.listComment.length +
                          (state.hasReachedEnd ? 0 : 1),
                    ),
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  void _loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      commentBloc.add(FetchEvent());
    }
  }

  Future<void> _refreshData(dynamic value) async {
    commentBloc.add(RefreshEvent());
  }

  Future<void> _refresh() async {
    commentBloc.add(RefreshEvent());
  }
}
