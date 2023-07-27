
import 'package:flutter_news_app_clean_architecture/data/dataSource/remote/dto/news_dto.dart';
import 'package:retrofit/retrofit.dart';

abstract class RemoteDataSource {
  Future<HttpResponse<NewsDto>> getNewsDto(
    String? apiKey,
    String? category,
    int? pageSize,
    int? page,
  );
}
