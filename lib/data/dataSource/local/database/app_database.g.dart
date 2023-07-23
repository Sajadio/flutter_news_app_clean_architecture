// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ArticleDao? _articleDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ArticleEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `source` TEXT, `author` TEXT, `title` TEXT, `description` TEXT, `url` TEXT, `urlToImage` TEXT, `publishedAt` TEXT, `content` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ArticleDao get articleDao {
    return _articleDaoInstance ??= _$ArticleDao(database, changeListener);
  }
}

class _$ArticleDao extends ArticleDao {
  _$ArticleDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _articleEntityInsertionAdapter = InsertionAdapter(
            database,
            'ArticleEntity',
            (ArticleEntity item) => <String, Object?>{
                  'id': item.id,
                  'source': _sourceConverter.encode(item.source),
                  'author': item.author,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'urlToImage': item.urlToImage,
                  'publishedAt': item.publishedAt,
                  'content': item.content
                },
            changeListener),
        _articleEntityDeletionAdapter = DeletionAdapter(
            database,
            'ArticleEntity',
            ['id'],
            (ArticleEntity item) => <String, Object?>{
                  'id': item.id,
                  'source': _sourceConverter.encode(item.source),
                  'author': item.author,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'urlToImage': item.urlToImage,
                  'publishedAt': item.publishedAt,
                  'content': item.content
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ArticleEntity> _articleEntityInsertionAdapter;

  final DeletionAdapter<ArticleEntity> _articleEntityDeletionAdapter;

  @override
  Stream<List<ArticleEntity>> getAllSavedArticles() {
    return _queryAdapter.queryListStream('SELECT * FROM ArticleEntity',
        mapper: (Map<String, Object?> row) => ArticleEntity(
            id: row['id'] as int?,
            source: _sourceConverter.decode(row['source'] as String),
            author: row['author'] as String?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            url: row['url'] as String?,
            urlToImage: row['urlToImage'] as String?,
            publishedAt: row['publishedAt'] as String?,
            content: row['content'] as String?),
        queryableName: 'ArticleEntity',
        isView: false);
  }

  @override
  Future<void> deleteHistoryArticles() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ArticleEntity');
  }

  @override
  Future<bool?> didArticleSave(String url) async {
    return _queryAdapter.query(
        'SELECT EXISTS (SELECT 1 FROM ArticleEntity WHERE url = ?1 LIMIT 1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [url]);
  }

  @override
  Future<void> addArticlesToSearchHistory(
      List<ArticleEntity> articlesEntity) async {
    await _articleEntityInsertionAdapter.insertList(
        articlesEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> addArticle(ArticleEntity articleEntity) async {
    await _articleEntityInsertionAdapter.insert(
        articleEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteArticle(ArticleEntity articleEntity) async {
    await _articleEntityDeletionAdapter.delete(articleEntity);
  }
}

// ignore_for_file: unused_element
final _sourceConverter = SourceConverter();
