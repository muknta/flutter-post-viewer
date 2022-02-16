import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_viewer/domain/entities/comment_entity.dart';
import 'package:page_viewer/domain/entities/post_entity.dart';
import 'package:page_viewer/presentation/blocs/post_viewer_bloc/post_viewer_bloc.dart';
import 'package:page_viewer/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:page_viewer/presentation/themes/i_post_page_theme.dart';
import 'package:page_viewer/presentation/widgets/layout/main_scaffold.dart';
import 'package:page_viewer/presentation/widgets/simplifiers/text_widget.dart';

class PostPage extends StatefulWidget {
  PostPage({Key? key, required PostEntity post, required List<CommentEntity> commentList})
      : _post = post,
        _commentList = commentList,
        _title = 'Post ${post.id}',
        super(key: key);

  final PostEntity _post;
  final List<CommentEntity> _commentList;
  final String _title;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late final IPostPageTheme _theme;
  late final PostViewerBloc _postBloc;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _theme = context.readBloc<ThemeBloc>().theme.postPageTheme;
    _postBloc = context.readBloc<PostViewerBloc>();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MainScaffold(
        onBackButtonTap: () => _postBloc.addEvent(const TapOnBackButtonFromPostPageEvent()),
        title: widget._title,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextWidget(
                      'User ${widget._post.userId}',
                      fontSize: 18,
                      color: _theme.textColor,
                      textAlign: TextAlign.right,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeadlineTextWidget('Title', theme: _theme),
                        _OrdinaryTextWidget(
                          widget._post.title,
                          theme: _theme,
                          maxLines: 5,
                        ),
                        _HeadlineTextWidget('Body', theme: _theme),
                        _OrdinaryTextWidget(
                          widget._post.body,
                          theme: _theme,
                          maxLines: 10000,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                _HeadlineTextWidget('Comments', theme: _theme),
                ListView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  children: List.generate(
                    widget._commentList.length,
                    (index) => _CommentWidget(
                      comment: widget._commentList.elementAt(index),
                      index: index,
                      theme: _theme,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _CommentWidget extends StatelessWidget {
  const _CommentWidget({Key? key, required CommentEntity comment, required int index, required IPostPageTheme theme})
      : _comment = comment,
        _index = index,
        _theme = theme,
        super(key: key);

  final CommentEntity _comment;
  final int _index;
  final IPostPageTheme _theme;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CommentParagraphTitleText('Name', theme: _theme),
              _CommentParagraphTitleText('${_index + 1} (id ${_comment.id})',
                  align: Alignment.centerRight, theme: _theme),
            ],
          ),
          _CommentContentText(
            _comment.name,
            theme: _theme,
            maxLines: 2,
          ),
          const SizedBox(height: 10),
          _CommentParagraphTitleText('Email', theme: _theme),
          _CommentContentText(
            _comment.email,
            theme: _theme,
            maxLines: 2,
          ),
          const SizedBox(height: 10),
          _CommentParagraphTitleText('Message', theme: _theme),
          _CommentContentText(
            _comment.body,
            theme: _theme,
            maxLines: 100,
          ),
        ],
      );
}

class _HeadlineTextWidget extends StatelessWidget {
  const _HeadlineTextWidget(
    String text, {
    Key? key,
    required IPostPageTheme theme,
  })  : _text = text,
        _theme = theme,
        super(key: key);

  final String _text;
  final IPostPageTheme _theme;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
        child: TextWidget(
          _text,
          fontSize: 40,
          color: _theme.textColor,
        ),
      );
}

class _OrdinaryTextWidget extends StatelessWidget {
  const _OrdinaryTextWidget(
    String text, {
    Key? key,
    required IPostPageTheme theme,
    int? maxLines,
  })  : _text = text,
        _theme = theme,
        _maxLines = maxLines,
        super(key: key);

  final String _text;
  final IPostPageTheme _theme;
  final int? _maxLines;

  @override
  Widget build(BuildContext context) => TextWidget(
        _text,
        fontSize: 20,
        color: _theme.textColor,
        maxLines: _maxLines,
      );
}

class _CommentParagraphTitleText extends StatelessWidget {
  const _CommentParagraphTitleText(
    String text, {
    Key? key,
    required IPostPageTheme theme,
    Alignment align = Alignment.centerLeft,
    int? maxLines,
  })  : _text = text,
        _theme = theme,
        _align = align,
        _maxLines = maxLines,
        super(key: key);

  final String _text;
  final IPostPageTheme _theme;
  final Alignment _align;
  final int? _maxLines;

  @override
  Widget build(BuildContext context) => Align(
        alignment: _align,
        child: TextWidget(
          _text,
          fontSize: 15,
          color: _theme.textColor,
          maxLines: _maxLines,
        ),
      );
}

class _CommentContentText extends StatelessWidget {
  const _CommentContentText(
    String text, {
    Key? key,
    required IPostPageTheme theme,
    int? maxLines,
  })  : _text = text,
        _theme = theme,
        _maxLines = maxLines,
        super(key: key);

  final String _text;
  final IPostPageTheme _theme;
  final int? _maxLines;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 1000.0,
          ),
          child: TextWidget(
            _text,
            fontSize: 18,
            color: _theme.textColor,
            maxLines: _maxLines,
          ),
        ),
      );
}
