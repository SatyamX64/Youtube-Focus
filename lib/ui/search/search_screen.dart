import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import 'bloc/bloc.dart';
import 'widgets/widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchBloc = KiwiContainer().resolve<SearchBloc>();
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchBloc,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SearchBar(),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.isInitial) {
                      return _buildInitialWidget();
                    } else if (state.isLoading) {
                      return _buildLoadingWidget();
                    } else if (state.isSuccessful) {
                      return _buildResultList(state);
                    } else {
                      return _buildErrorWidget(state.error);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultList(SearchState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: _calculateListItemCount(state),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return index >= state.items.length
              ? _buildListLoader()
              : VideoItemCard(item: state.items[index]);
        },
        separatorBuilder: (_, __) => SizedBox(
          height: 8,
        ),
      ),
    );
  }

  int _calculateListItemCount(SearchState state) {
    if (state.hasReachedEndOfResults) {
      return state.items.length;
    } else {
      return state.items.length + 1;
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _searchBloc.fetchNextPage();
    }
    return false;
  }

  Widget _buildErrorWidget(String message) {
    return CenteredMessage(
      icon: Icons.error,
      message: message,
    );
  }

  Widget _buildInitialWidget() {
    return CenteredMessage(
      icon: Icons.ondemand_video,
      message: 'Please Search Something',
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildListLoader() {
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: CircularProgressIndicator()),
    );
  }
}
