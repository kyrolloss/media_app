import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_app/models/video_model/video_model.dart';
import 'package:media_app/shared/constants/constants.dart';
import 'package:media_app/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:media_app/shared/network/remote/end_points/end_points.dart';
import 'package:meta/meta.dart';

import '../../../models/image_model/image_model.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  List<ImageModel> images = [];
  List<VideoModel> videos = [];

  Map<int,bool> downloadMap = {};


  // Last Session Logic
  void getImages({
    required String text,
  }) {
    images = [];
    emit(GetImagesLoading());
    DioHelper.getData(url: PHOTO_SEARCH, token: API_KEY, query: {
      'query': text,
    }).then((value) {
      if (value.statusCode == 200) {
        value.data['photos'].forEach((element) {
          var image = ImageModel.fromJson(element);
          images.add(image);
        });
        emit(GetImagesSuccessfully());
      } else {
        if (kDebugMode) {
          print(value.data);
        }
        emit(GetImagesError());
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetImagesError());
    });
  }

  void getVideos({
    required String text,
  }) {
    videos = [];
    emit(GetVideosLoading());
    DioHelper.getData(url: VIDEO_SEARCH, token: API_KEY, query: {
      'query': text,
    }).then((value) {
      if (value.statusCode == 200) {
        value.data['videos'].forEach((element) {
          var video = VideoModel.fromJson(element);
          videos.add(video);
        });
        emit(GetVideosSuccessfully());
      } else {
        if (kDebugMode) {
          print(value.data);
        }
        emit(GetVideosError());
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetVideosError());
    });
  }


  //New Logic

  // change favourite or download media here
  void downloadMedia({
  required int mediaId,
  required ProgressCallback fn,
  ImageModel? imageModel,
  VideoModel? videoModel,

}){
    if (
    downloadMap [ mediaId]== null || downloadMap [ mediaId]==false
    ){
      downloadMap [mediaId] = true;
      if (
      imageModel == null
      ){
        DioHelper.download(directory: 'pexels ved',
            file: videoModel!.id.toString(),
            extension: 'mp4',
            url: videoModel.url,
            fn: fn);

      }
      else {
        DioHelper.download(directory: 'pexels img',
            file: videoModel!.id.toString(),
            extension: 'png',
            url: imageModel.url,
            fn: fn);
      }



    }

    // Write your code here
  }

  // get favourite or downloaded media here
  void getDownloadedMedia(){
    // Write your code here !!
  }


}
