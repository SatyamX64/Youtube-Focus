import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_focus/ui/search/bloc/bloc.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search videos',
        border: InputBorder.none,
        icon: Icon(
          Icons.search,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      onSubmitted: (searchQuery) {
        BlocProvider.of<SearchBloc>(context).searchVideos(query: searchQuery);
      },
      controller: _controller,
      focusNode: _focusNode,
    );
  }
}
