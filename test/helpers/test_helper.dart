import 'package:ditonton_siapa/data/datasources/db/database_helper.dart';
import 'package:ditonton_siapa/data/datasources/db/database_helper_tv.dart';
import 'package:ditonton_siapa/data/datasources/local/local_data_source.dart';
import 'package:ditonton_siapa/data/datasources/local/tv/local_data_source_tv.dart';
import 'package:ditonton_siapa/data/datasources/remote/remote_data_source.dart';
import 'package:ditonton_siapa/domain/repositories/movie_respository.dart';
import 'package:ditonton_siapa/domain/repositories/tv_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  TvLocalDataSource,
  MovieLocalDataSource,
  DatabaseHelperTv,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
