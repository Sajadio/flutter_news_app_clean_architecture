// ignore_for_file: avoid_print

import 'package:flutter_news_app_clean_architecture/data/dataSource/remote/dto/news_dto.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/remote_data_source.dart';

import 'package:dio/dio.dart';
import 'package:flutter_news_app_clean_architecture/utils/constant.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ApiService implements RemoteDataSource {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/top-headlines")
  @override
  Future<HttpResponse<NewsDto>> getNewsDto(
    @Query("apiKey") String? apiKey,
    @Query("category") String? category,
    @Query("pageSize") int? pageSize,
    @Query("page") int? page,
  );
}
