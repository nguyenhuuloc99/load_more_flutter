import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable{

}
class FetchEvent extends CommentEvent {
  @override
  List<Object?> get props => [];

}
class RefreshEvent extends CommentEvent {
  @override
  List<Object?> get props => [];

}
