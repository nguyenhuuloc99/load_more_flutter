import 'package:equatable/equatable.dart';

import '../model/comment.dart';

abstract class CommentState extends Equatable{

}
class CommentLoading extends CommentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class CommentSuccess extends CommentState {
  List<Comment> listComment;
  bool hasReachedEnd;


  CommentSuccess({required this.listComment,required this.hasReachedEnd});

  @override
  // TODO: implement props
  List<Object?> get props => [listComment,hasReachedEnd];

   CommentSuccess cloneWith({List<Comment>? list, bool? hasReachedEnd}) {
    return CommentSuccess(listComment: list ?? listComment, hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }
}