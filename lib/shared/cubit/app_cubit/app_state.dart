part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}


class GetImagesLoading extends AppState{}
class GetImagesSuccessfully extends AppState{}
class GetImagesError extends AppState{}

class GetVideosLoading extends AppState{}
class GetVideosSuccessfully extends AppState{}
class GetVideosError extends AppState{}






