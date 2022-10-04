part of 'map_page_bloc.dart';

@immutable
abstract class MapPageEvent {}

class GetLocationCurrentEvent extends MapPageEvent {}
class GetListCarEvent extends MapPageEvent {}
