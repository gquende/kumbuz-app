// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

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

  IncomeDao? _incomeDaoInstance;

  ExpenseDao? _expenseDaoInstance;

  UserDao? _userDaoInstance;

  WalletDao? _walletDaoInstance;

  WalletTransactionDao? _walletTransactionDaoInstance;

  BudgetDao? _budgetDaoInstance;

  CategoryImpl? _categoryDaoInstance;

  GoalsDAO? _goalsDaoInstance;

  DebtDao? _debtDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `incomes` (`id2` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `userId` TEXT NOT NULL, `uuId` TEXT, `date` TEXT NOT NULL, `time` TEXT NOT NULL, `amount` REAL NOT NULL, `description` TEXT NOT NULL, `categoryId` TEXT NOT NULL, `walletId` INTEGER NOT NULL, `recurring` INTEGER NOT NULL, `periodyRecurring` TEXT, `createAt` TEXT, `updateAt` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `uuId` TEXT NOT NULL, `name` TEXT NOT NULL, `surname` TEXT NOT NULL, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `financialProfile` TEXT NOT NULL, `createAt` TEXT, `updateAt` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `wallets` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `uuId` TEXT, `userId` TEXT NOT NULL, `name` TEXT NOT NULL, `amount` REAL NOT NULL, `excludeInTotal` INTEGER NOT NULL, `iconUrl` TEXT NOT NULL, `type` TEXT NOT NULL, `color` TEXT NOT NULL, `createAt` TEXT, `updateAt` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `transactions` (`id2` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT NOT NULL, `uuId` TEXT, `walletId` TEXT NOT NULL, `itemId` TEXT NOT NULL, `amount` REAL NOT NULL, `type` TEXT NOT NULL, `date` TEXT NOT NULL, `time` TEXT NOT NULL, `createAt` TEXT, `updateAt` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `expenses` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `userId` TEXT NOT NULL, `uuId` TEXT, `date` TEXT NOT NULL, `time` TEXT NOT NULL, `amount` REAL NOT NULL, `description` TEXT NOT NULL, `category` TEXT NOT NULL, `walletId` INTEGER NOT NULL, `recurring` INTEGER NOT NULL, `periodyRecurring` TEXT, `createAt` TEXT, `updateAt` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `budgets` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `uuid` TEXT NOT NULL, `categoryId` TEXT NOT NULL, `userUUId` TEXT NOT NULL, `name` TEXT NOT NULL, `category` TEXT NOT NULL, `amount` REAL NOT NULL, `amountConsume` REAL, `initialDate` TEXT NOT NULL, `endDate` TEXT NOT NULL, `percentComplete` REAL, `createAt` TEXT, `updateAt` TEXT)');

        await database.execute(''' CREATE TABLE IF NOT EXISTS `categories` 
          (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
          `uuid` TEXT NOT NULL, 
          `userId` TEXT, 
          `name` TEXT NOT NULL, 
          `color` TEXT, 
          `iconUrl` TEXT, 
          `value` REAL, 
          `type` TEXT)
      ''');

        await database.execute(
            'CREATE TABLE IF NOT EXISTS `goals` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `uuId` TEXT NOT NULL, `userId` TEXT NOT NULL, `name` TEXT NOT NULL, `amountTarget` REAL NOT NULL, `amount` REAL NOT NULL, `date` TEXT NOT NULL, `targetDate` TEXT NOT NULL, `color` TEXT, `percentDone` REAL, `isDone` INTEGER NOT NULL, `createAt` TEXT, `updateAt` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `debts` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `uuid` TEXT NOT NULL, `userId` TEXT NOT NULL, `walletId` TEXT NOT NULL, `type` TEXT NOT NULL, `from` TEXT NOT NULL, `to` TEXT NOT NULL, `amountTarget` REAL NOT NULL, `amount` REAL NOT NULL, `date` TEXT NOT NULL, `time` TEXT NOT NULL, `isDone` INTEGER NOT NULL, `description` TEXT NOT NULL, `color` TEXT NOT NULL, `createAt` TEXT, `updateAt` TEXT)');

        await database.execute('''CREATE TABLE IF NOT EXISTS `notifications` 
            (`id` TEXT PRIMARY KEY NOT NULL, 
            `title` TEXT NOT NULL, 
            `message` TEXT NOT NULL, 
            `datetime` TEXT NOT NULL, 
            `status` TEXT NOT NULL,
            `type` TEXT NOT NULL)
            ''');

        await database.execute('''CREATE TABLE IF NOT EXISTS `bank_accounts` 
            (`uuid` TEXT PRIMARY KEY NOT NULL, 
            `userId` TEXT NOT NULL, 
            `type` TEXT NOT NULL, 
            `bankName` TEXT NOT NULL, 
            `accountNumber` TEXT NOT NULL,
            `currency` TEXT,
            `createAt` TEXT NOT NULL,
            `updateAt` TEXT NOT NULL)
            ''');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  IncomeDao get incomeDao {
    return _incomeDaoInstance ??= _$IncomeDao(database, changeListener);
  }

  @override
  ExpenseDao get expenseDao {
    return _expenseDaoInstance ??= _$ExpenseDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  WalletDao get walletDao {
    return _walletDaoInstance ??= _$WalletDao(database, changeListener);
  }

  @override
  WalletTransactionDao get walletTransactionDao {
    return _walletTransactionDaoInstance ??=
        _$WalletTransactionDao(database, changeListener);
  }

  @override
  BudgetDao get budgetDao {
    return _budgetDaoInstance ??= _$BudgetDao(database, changeListener);
  }

  @override
  CategoryImpl get categoryDao {
    return _categoryDaoInstance ??= _$CategoryImpl(database, changeListener);
  }

  @override
  GoalsDAO get goalsDao {
    return _goalsDaoInstance ??= _$GoalsDAO(database, changeListener);
  }

  @override
  DebtDao get debtDao {
    return _debtDaoInstance ??= _$DebtDao(database, changeListener);
  }
}

class _$IncomeDao extends IncomeDao {
  _$IncomeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _incomeInsertionAdapter = InsertionAdapter(
            database,
            'incomes',
            (Income item) => <String, Object?>{
                  //'id2': item.id2,
                  'userId': item.userId,
                  'uuId': item.uuId,
                  'date': item.date,
                  'time': item.time,
                  'amount': item.amount,
                  'description': item.description,
                  'categoryId': item.categoryId,
                  'walletId': item.walletId,
                  'recurring': item.recurring ? 1 : 0,
                  'periodyRecurring': item.periodyRecurring,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _incomeUpdateAdapter = UpdateAdapter(
            database,
            'incomes',
            ['id2'],
            (Income item) => <String, Object?>{
                  'id2': item.id2,
                  'userId': item.userId,
                  'uuId': item.uuId,
                  'date': item.date,
                  'time': item.time,
                  'amount': item.amount,
                  'description': item.description,
                  'categoryId': item.categoryId,
                  'walletId': item.walletId,
                  'recurring': item.recurring ? 1 : 0,
                  'periodyRecurring': item.periodyRecurring,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _incomeDeletionAdapter = DeletionAdapter(
            database,
            'incomes',
            ['id2'],
            (Income item) => <String, Object?>{
                  'id2': item.id2,
                  'userId': item.userId,
                  'uuId': item.uuId,
                  'date': item.date,
                  'time': item.time,
                  'amount': item.amount,
                  'description': item.description,
                  'categoryId': item.categoryId,
                  'walletId': item.walletId,
                  'recurring': item.recurring ? 1 : 0,
                  'periodyRecurring': item.periodyRecurring,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Income> _incomeInsertionAdapter;

  final UpdateAdapter<Income> _incomeUpdateAdapter;

  final DeletionAdapter<Income> _incomeDeletionAdapter;

  @override
  Future<Income?> getById(int id) async {
    return _queryAdapter.query('Select * from incomes where id2 = ?1',
        mapper: (Map<String, Object?> row) => Income(
            row['id2'] as int,
            row['userId'] as String,
            row['date'] as String,
            row['time'] as String,
            row['amount'] as double,
            row['description'] as String,
            row['categoryId'] as String,
            row['walletId'] as int,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [id]);
  }

  @override
  Future<List<Income>> getAll() async {
    return _queryAdapter.queryList('Select * from incomes',
        mapper: (Map<String, Object?> row) => Income(
            row['id2'] as int,
            row['userId'] as String,
            row['date'] as String,
            row['time'] as String,
            row['amount'] as double,
            row['description'] as String,
            row['categoryId'] as String,
            row['walletId'] as int,
            row['createAt'] as String,
            row['updateAt'] as String));
  }

  @override
  Future<double?> getTotalIncomes() async {
    return await _queryAdapter.query('Select Sum(amount) as valor from incomes',
        mapper: (Map<String, Object?> row) => row['valor'] as double);
  }

  @override
  Future<double?> getTotalAmountOfMonth(String month) async {
    return await _queryAdapter.query(
        'Select sum(amount) as total from incomes where STRFTIME(\'%Y-%m\', date)= ?1',
        arguments: [month],
        mapper: (Map<String, Object?> row) => row['total'] as double);
  }

  @override
  Future<int> insertItem(Income item) {
    return _incomeInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Income item) {
    return _incomeUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(Income item) {
    return _incomeDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}

class _$ExpenseDao extends ExpenseDao {
  _$ExpenseDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _expenseInsertionAdapter = InsertionAdapter(
            database,
            'expenses',
            (Expense item) => <String, Object?>{
                  //'id': item.id,
                  'userId': item.userId,
                  'uuId': item.uuId,
                  'date': item.date,
                  'time': item.time,
                  'amount': item.amount,
                  'description': item.description,
                  'category': item.category,
                  'walletId': item.walletId,
                  'recurring': item.recurring ? 1 : 0,
                  'periodyRecurring': item.periodyRecurring,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _expenseUpdateAdapter = UpdateAdapter(
            database,
            'expenses',
            ['id'],
            (Expense item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'uuId': item.uuId,
                  'date': item.date,
                  'time': item.time,
                  'amount': item.amount,
                  'description': item.description,
                  'category': item.category,
                  'walletId': item.walletId,
                  'recurring': item.recurring ? 1 : 0,
                  'periodyRecurring': item.periodyRecurring,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _expenseDeletionAdapter = DeletionAdapter(
            database,
            'expenses',
            ['id'],
            (Expense item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'uuId': item.uuId,
                  'date': item.date,
                  'time': item.time,
                  'amount': item.amount,
                  'description': item.description,
                  'category': item.category,
                  'walletId': item.walletId,
                  'recurring': item.recurring ? 1 : 0,
                  'periodyRecurring': item.periodyRecurring,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Expense> _expenseInsertionAdapter;

  final UpdateAdapter<Expense> _expenseUpdateAdapter;

  final DeletionAdapter<Expense> _expenseDeletionAdapter;

  @override
  Future<Expense?> getById(int id) async {
    return _queryAdapter.query('Select * from expenses where id = ?1',
        mapper: (Map<String, Object?> row) => Expense(
            row['id'] as int,
            row['userId'] as String,
            row['date'] as String,
            row['time'] as String,
            row['amount'] as double,
            row['description'] as String,
            row['category'] as String,
            row['walletId'] as int,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [id]);
  }

  @override
  Future<List<Expense>> getAll() async {
    return _queryAdapter.queryList('Select * from expenses',
        mapper: (Map<String, Object?> row) => Expense(
            row['id'] as int,
            row['userId'] as String,
            row['date'] as String,
            row['time'] as String,
            row['amount'] as double,
            row['description'] as String,
            row['category'] as String,
            row['walletId'] as int,
            row['createAt'] as String,
            row['updateAt'] as String));
  }

  @override
  Future<double?> getTotalIncomes() async {
    return _queryAdapter.query('Select Sum(amount) as valor from expenses',
        mapper: (Map<String, Object?> row) => row['valor'] as double);
  }

  @override
  Future<double?> getTotalAmountOfMonth(String date) async {
    return _queryAdapter.query(
        'Select sum(amount) as total from expenses where STRFTIME(\'%Y-%m\', date)= ?1',
        arguments: [date],
        mapper: (Map<String, Object?> row) => row['total'] as double);
  }

  @override
  Future<double?> getTotalAmountOfMonthWithCategory(
      String month, String category) async {
    return await _queryAdapter.query(
        'Select sum(amount) as total from expenses where STRFTIME(\'%m\', date)= ?1 and category= ?2',
        arguments: [month, category],
        mapper: (Map<String, Object?> row) => row['total'] as double);
  }

  @override
  Future<List<Expense>> getAllForMonthOfCategory(
      String date, String category) async {
    return _queryAdapter.queryList(
        'Select * from expenses where STRFTIME(\'%Y-%m\', date)= ?1 and category= ?2',
        mapper: (Map<String, Object?> row) => Expense(row['id'] as int, row['userId'] as String, row['date'] as String, row['time'] as String, row['amount'] as double, row['description'] as String, row['category'] as String, row['walletId'] as int, row['createAt'] as String, row['updateAt'] as String),
        arguments: [date, category]);
  }

  @override
  Future<List<Expense>> getAllForMonth(String date) async {
    return _queryAdapter.queryList(
        'SELECT * FROM expenses WHERE STRFTIME(\'%Y-%m\', date)= ?1',
        mapper: (Map<String, Object?> row) => Expense(
            row['id'] as int,
            row['userId'] as String,
            row['date'] as String,
            row['time'] as String,
            row['amount'] as double,
            row['description'] as String,
            row['category'] as String,
            row['walletId'] as int,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [date]);
  }

  @override
  Future<List<Expense>> getAllOfDay(String date) async {
    return _queryAdapter.queryList(
        'SELECT * FROM expenses WHERE date= ?1 ORDER BY createAt DESC',
        mapper: (Map<String, Object?> row) => Expense(
            row['id'] as int,
            row['userId'] as String,
            row['date'] as String,
            row['time'] as String,
            row['amount'] as double,
            row['description'] as String,
            row['category'] as String,
            row['walletId'] as int,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [date]);
  }

  @override
  Future<List<CategoryModel>?> getSumByCategoryOfMonth(String date) async {
    var data = await _queryAdapter.queryList(
        'SELECT sum(amount) as total,categories.uuid, categories.id,categories.userId, name, color, iconUrl from expenses inner join categories on expenses.category=categories.name WHERE STRFTIME(\'%Y-%m\',date)= ?1 GROUP by category',
        arguments: [date],
        mapper: (Map<String, Object?> row) => CategoryModel(
            row['id'] as int,
            row['uuid'] as String,
            row['userId'] as String,
            row['name'] as String,
            row['color'] as String,
            row['iconUrl'] as String,
            row['total'] as double,
            row["type"] == null ? "" : row["type"] as String));

    print("getSumByCategoryOfMonth:: DBADAPTER");
    print(data);

    return data;
  }

  @override
  Future<int> insertItem(Expense item) {
    return _expenseInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Expense item) {
    return _expenseUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(Expense item) {
    return _expenseDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'uuId': item.uuId,
                  'name': item.name,
                  'surname': item.surname,
                  'email': item.email,
                  'password': item.password,
                  'financialProfile': item.financialProfile,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _userUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'uuId': item.uuId,
                  'name': item.name,
                  'surname': item.surname,
                  'email': item.email,
                  'password': item.password,
                  'financialProfile': item.financialProfile,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _userDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'uuId': item.uuId,
                  'name': item.name,
                  'surname': item.surname,
                  'email': item.email,
                  'password': item.password,
                  'financialProfile': item.financialProfile,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final UpdateAdapter<User> _userUpdateAdapter;

  final DeletionAdapter<User> _userDeletionAdapter;

  @override
  Future<User?> getByUsernameAndPassword(
      String username, String password) async {
    return _queryAdapter.query(
        'select * from users where  username= ?1 and password= ?2',
        mapper: (Map<String, Object?> row) => User(
            row['id'] as int,
            row['uuId'] as String,
            row['name'] as String,
            row['surname'] as String,
            row['email'] as String,
            row['password'] as String,
            row['financialProfile'] as String,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [username, password]);
  }

  @override
  Future<int> insertItem(User item) {
    return _userInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(User item) {
    return _userUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(User item) {
    return _userDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}

class _$WalletDao extends WalletDao {
  _$WalletDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _walletInsertionAdapter = InsertionAdapter(
            database,
            'wallets',
            (Wallet item) => <String, Object?>{
                  //'id': item.id,
                  'uuId': item.uuId,
                  'userId': item.userId,
                  'name': item.name,
                  'amount': item.amount,
                  'excludeInTotal': item.excludeInTotal ? 1 : 0,
                  'iconUrl': item.iconUrl,
                  'type': item.type,
                  'color': item.color,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _walletUpdateAdapter = UpdateAdapter(
            database,
            'wallets',
            ['id'],
            (Wallet item) => <String, Object?>{
                  'id': item.id,
                  'uuId': item.uuId,
                  'userId': item.userId,
                  'name': item.name,
                  'amount': item.amount,
                  'excludeInTotal': item.excludeInTotal ? 1 : 0,
                  'iconUrl': item.iconUrl,
                  'type': item.type,
                  'color': item.color,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _walletDeletionAdapter = DeletionAdapter(
            database,
            'wallets',
            ['id'],
            (Wallet item) => <String, Object?>{
                  'id': item.id,
                  'uuId': item.uuId,
                  'userId': item.userId,
                  'name': item.name,
                  'amount': item.amount,
                  'excludeInTotal': item.excludeInTotal ? 1 : 0,
                  'iconUrl': item.iconUrl,
                  'type': item.type,
                  'color': item.color,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Wallet> _walletInsertionAdapter;

  final UpdateAdapter<Wallet> _walletUpdateAdapter;

  final DeletionAdapter<Wallet> _walletDeletionAdapter;

  @override
  Future<Wallet?> getById(int id) async {
    return _queryAdapter.query('Select * from wallets where id = ?1',
        mapper: (Map<String, Object?> row) => Wallet(
            row['id'] as int,
            row['userId'] as String,
            row['name'] as String,
            row['amount'] as double,
            (row['excludeInTotal'] as int) != 0,
            row['iconUrl'] as String,
            row['type'] as String,
            row['color'] as String,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [id]);
  }

  @override
  Future<List<Wallet>> getAll() async {
    return _queryAdapter.queryList('Select * from wallets',
        mapper: (Map<String, Object?> row) => Wallet(
            row['id'] as int,
            row['userId'] as String,
            row['name'] as String,
            row['amount'] as double,
            (row['excludeInTotal'] as int) != 0,
            row['iconUrl'] as String,
            row['type'] as String,
            row['color'] as String,
            row['createAt'] as String,
            row['updateAt'] as String));
  }

  @override
  Future<double?> getTotalAmountOfWallets() async {
    return await _queryAdapter.query('Select Sum(amount) as valor from wallets',
        mapper: (Map<String, Object?> row) => row['valor'] as double);
  }

  @override
  Future<double?> getAmountOfWallet(int id) async {
    return await _queryAdapter.query('Select amount from wallets where id= ?1',
        arguments: [id],
        mapper: (Map<String, Object?> row) => row['amount'] as double);
  }

  @override
  Future<int> insertItem(Wallet item) {
    return _walletInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Wallet item) {
    return _walletUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(Wallet item) {
    return _walletDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}

class _$WalletTransactionDao extends WalletTransactionDao {
  _$WalletTransactionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _walletTransactionInsertionAdapter = InsertionAdapter(
            database,
            'transactions',
            (WalletTransaction item) => <String, Object?>{
                  'id2': item.id2,
                  'description': item.description,
                  'uuId': item.uuid,
                  'walletId': item.walletId,
                  'itemId': item.itemId,
                  'amount': item.amount,
                  'type': item.type,
                  'date': item.date,
                  'time': item.time,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _walletTransactionUpdateAdapter = UpdateAdapter(
            database,
            'transactions',
            ['id2'],
            (WalletTransaction item) => <String, Object?>{
                  'id2': item.id2,
                  'description': item.description,
                  'uuId': item.uuid,
                  'walletId': item.walletId,
                  'itemId': item.itemId,
                  'amount': item.amount,
                  'type': item.type,
                  'date': item.date,
                  'time': item.time,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _walletTransactionDeletionAdapter = DeletionAdapter(
            database,
            'transactions',
            ['id2'],
            (WalletTransaction item) => <String, Object?>{
                  'id2': item.id2,
                  'description': item.description,
                  'uuId': item.uuid,
                  'walletId': item.walletId,
                  'itemId': item.itemId,
                  'amount': item.amount,
                  'type': item.type,
                  'date': item.date,
                  'time': item.time,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WalletTransaction> _walletTransactionInsertionAdapter;

  final UpdateAdapter<WalletTransaction> _walletTransactionUpdateAdapter;

  final DeletionAdapter<WalletTransaction> _walletTransactionDeletionAdapter;

  @override
  Future<WalletTransaction?> getById(int id) async {
    return _queryAdapter.query('Select * from transactions where id = ?1',
        mapper: (Map<String, Object?> row) => WalletTransaction(
            row['uuId'] as String,
            row['description'] as String,
            row['walletId'] as String,
            row['itemId'] as String,
            row['amount'] as double,
            row['type'] as String,
            row['date'] as String,
            row['time'] as String,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [id]);
  }

  @override
  Future<List<WalletTransaction>> getAll() async {
    return _queryAdapter.queryList(
        'SELECT * FROM transactions ORDER BY date DESC',
        mapper: (Map<String, Object?> row) => WalletTransaction(
            row['uuId'] as String,
            row['description'] as String,
            row['walletId'] as String,
            row['itemId'] as String,
            row['amount'] as double,
            row['type'] as String,
            row['date'] as String,
            row['time'] as String,
            row['createAt'] as String,
            row['updateAt'] as String));
  }

  @override
  Future<List<WalletTransaction>> getWalletTransaction(String uuid) async {
    var data = await _queryAdapter.queryList(
        'SELECT * FROM transactions where walletId = ?1',
        mapper: (Map<String, Object?> row) => WalletTransaction(
            row['uuId'] as String,
            row['description'] as String,
            row['walletId'] as String,
            row['itemId'] as String,
            row['amount'] as double,
            row['type'] as String,
            row['date'] as String,
            row['time'] as String,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [uuid]);

    return data;
  }

  @override
  Future<int> insertItem(WalletTransaction item) {
    return _walletTransactionInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(WalletTransaction item) {
    return _walletTransactionUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(WalletTransaction item) {
    return _walletTransactionDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}

class _$BudgetDao extends BudgetDao {
  _$BudgetDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _budgetInsertionAdapter = InsertionAdapter(
            database,
            'budgets',
            (Budget item) => <String, Object?>{
                  //  'id': item.id,
                  'uuid': item.uuid,
                  'categoryId': item.categoryId,
                  'userUUId': item.userUUId,
                  'name': item.name,
                  'category': item.category,
                  'amount': item.amount,
                  'amountConsume': item.amountConsume,
                  'initialDate': item.initialDate,
                  'endDate': item.endDate,
                  'percentComplete': item.percentComplete,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _budgetUpdateAdapter = UpdateAdapter(
            database,
            'budgets',
            ['id'],
            (Budget item) => <String, Object?>{
                  'id': item.id,
                  'uuid': item.uuid,
                  'categoryId': item.categoryId,
                  'userUUId': item.userUUId,
                  'name': item.name,
                  'category': item.category,
                  'amount': item.amount,
                  'amountConsume': item.amountConsume,
                  'initialDate': item.initialDate,
                  'endDate': item.endDate,
                  'percentComplete': item.percentComplete,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _budgetDeletionAdapter = DeletionAdapter(
            database,
            'budgets',
            ['id'],
            (Budget item) => <String, Object?>{
                  'id': item.id,
                  'uuid': item.uuid,
                  'categoryId': item.categoryId,
                  'userUUId': item.userUUId,
                  'name': item.name,
                  'category': item.category,
                  'amount': item.amount,
                  'amountConsume': item.amountConsume,
                  'initialDate': item.initialDate,
                  'endDate': item.endDate,
                  'percentComplete': item.percentComplete,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Budget> _budgetInsertionAdapter;

  final UpdateAdapter<Budget> _budgetUpdateAdapter;

  final DeletionAdapter<Budget> _budgetDeletionAdapter;

  @override
  Future<Budget?> getById(int id) async {
    return _queryAdapter.query('Select * from budgets where id = ?1',
        mapper: (Map<String, Object?> row) => Budget(
            row['id'] as int,
            row['uuid'] as String,
            row['categoryId'] as String,
            row['userUUId'] as String,
            row['name'] as String,
            row['category'] as String,
            row['amount'] as double,
            row['amountConsume'] as double?,
            row['initialDate'] as String,
            row['endDate'] as String,
            row['percentComplete'] as double?,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [id]);
  }

  @override
  Future<Budget?> getByUUID(String uuid) async {
    return _queryAdapter.query('Select * from budgets where uuid = ?1',
        mapper: (Map<String, Object?> row) => Budget(
            row['id'] as int,
            row['uuid'] as String,
            row['categoryId'] as String,
            row['userUUId'] as String,
            row['name'] as String,
            row['category'] as String,
            row['amount'] as double,
            row['amountConsume'] as double?,
            row['initialDate'] as String,
            row['endDate'] as String,
            row['percentComplete'] as double?,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [uuid]);
  }

  @override
  Future<List<Budget>> getAll() async {
    return _queryAdapter.queryList(
        'SELECT * FROM budgets ORDER BY createAt DESC',
        mapper: (Map<String, Object?> row) => Budget(
            row['id'] as int,
            row['uuid'] as String,
            row['categoryId'] as String,
            row['userUUId'] as String,
            row['name'] as String,
            row['category'] as String,
            row['amount'] as double,
            row['amountConsume'] as double?,
            row['initialDate'] as String,
            row['endDate'] as String,
            row['percentComplete'] as double?,
            row['createAt'] as String,
            row['updateAt'] as String));
  }

  @override
  Future<Budget?> getByCategory(String category) async {
    return _queryAdapter.query('Select * from budgets where category = ?1',
        mapper: (Map<String, Object?> row) => Budget(
            row['id'] as int,
            row['uuid'] as String,
            row['categoryId'] as String,
            row['userUUId'] as String,
            row['name'] as String,
            row['category'] as String,
            row['amount'] as double,
            row['amountConsume'] as double?,
            row['initialDate'] as String,
            row['endDate'] as String,
            row['percentComplete'] as double?,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [category]);
  }

  @override
  Future<List<Budget>> getForAPeriod(String datetime) async {
    return _queryAdapter.queryList(
        'Select * from budgets where initialDate = ?1',
        mapper: (Map<String, Object?> row) => Budget(
            row['id'] as int,
            row['uuid'] as String,
            row['categoryId'] as String,
            row['userUUId'] as String,
            row['name'] as String,
            row['category'] as String,
            row['amount'] as double,
            row['amountConsume'] as double?,
            row['initialDate'] as String,
            row['endDate'] as String,
            row['percentComplete'] as double?,
            row['createAt'] as String,
            row['updateAt'] as String),
        arguments: [datetime]);
  }

  @override
  Future<int> insertItem(Budget item) {
    return _budgetInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Budget item) {
    return _budgetUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(Budget item) {
    return _budgetDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}

class _$CategoryImpl extends CategoryImpl {
  _$CategoryImpl(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _categoryModelInsertionAdapter = InsertionAdapter(
            database,
            'categories',
            (CategoryModel item) => <String, Object?>{
                  // 'id': item.id,
                  'uuid': item.uuid,
                  'userId': item.userId,
                  'name': item.name,
                  'color': item.color,
                  'iconUrl': item.iconUrl,
                  'value': item.value,
                  'type': item.type ?? ""
                }),
        _categoryModelUpdateAdapter = UpdateAdapter(
            database,
            'categories',
            ['id'],
            (CategoryModel item) => <String, Object?>{
                  'id': item.id,
                  'uuid': item.uuid,
                  'userId': item.userId,
                  'name': item.name,
                  'color': item.color,
                  'iconUrl': item.iconUrl,
                  'value': item.value,
                  'type': item.type ?? ""
                }),
        _categoryModelDeletionAdapter = DeletionAdapter(
            database,
            'categories',
            ['id'],
            (CategoryModel item) => <String, Object?>{
                  'id': item.id,
                  'uuid': item.uuid,
                  'userId': item.userId,
                  'name': item.name,
                  'color': item.color,
                  'iconUrl': item.iconUrl,
                  'value': item.value,
                  'type': item.type ?? ""
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CategoryModel> _categoryModelInsertionAdapter;

  final UpdateAdapter<CategoryModel> _categoryModelUpdateAdapter;

  final DeletionAdapter<CategoryModel> _categoryModelDeletionAdapter;

  @override
  Future<CategoryModel?> getById(int id) async {
    return _queryAdapter.query('Select * from categories where id= ?1',
        mapper: (Map<String, Object?> row) => CategoryModel(
            row['id'] as int,
            row['uuid'] as String,
            row['userId'] as String,
            row['name'] as String,
            row['color'] as String,
            row['iconUrl'] as String,
            row['value'] as double,
            row["type"] as String),
        arguments: [id]);
  }

  @override
  Future<List<CategoryModel>?> getAllCategories() async {
    return _queryAdapter.queryList('Select * from categories',
        mapper: (Map<String, Object?> row) => CategoryModel(
            row['id'] as int,
            row['uuid'] as String,
            row['userId'] as String,
            row['name'] as String,
            row['color'] as String,
            row['iconUrl'] as String,
            row['value'] as double,
            "${row["type"]}"));
  }

  @override
  Future<List<CategoryModel>?> getAllCategoriesByType(String type) async {
    return _queryAdapter.queryList('Select * from categories where type= ?1',
        mapper: (Map<String, Object?> row) => CategoryModel(
            row['id'] as int,
            row['uuid'] as String,
            row['userId'] as String,
            row['name'] as String,
            row['color'] as String,
            row['iconUrl'] as String,
            row['value'] as double,
            "${row["type"]}"),
        arguments: [type]);
  }

  @override
  Future<int> insertItem(CategoryModel item) {
    return _categoryModelInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(CategoryModel item) {
    return _categoryModelUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(CategoryModel item) {
    return _categoryModelDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}

class _$GoalsDAO extends GoalsDAO {
  _$GoalsDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _goalsInsertionAdapter = InsertionAdapter(
            database,
            'goals',
            (Goals item) => <String, Object?>{
                  //'id': item.id,
                  'uuId': item.uuId,
                  'userId': item.userId,
                  'name': item.name,
                  'amountTarget': item.amountTarget,
                  'amount': item.amount,
                  'date': item.date,
                  'targetDate': item.targetDate,
                  'color': item.color,
                  'percentDone': item.percentDone,
                  'isDone': item.isDone ? 1 : 0,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _goalsUpdateAdapter = UpdateAdapter(
            database,
            'goals',
            ['id'],
            (Goals item) => <String, Object?>{
                  'id': item.id,
                  'uuId': item.uuId,
                  'userId': item.userId,
                  'name': item.name,
                  'amountTarget': item.amountTarget,
                  'amount': item.amount,
                  'date': item.date,
                  'targetDate': item.targetDate,
                  'color': item.color,
                  'percentDone': item.percentDone,
                  'isDone': item.isDone ? 1 : 0,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _goalsDeletionAdapter = DeletionAdapter(
            database,
            'goals',
            ['id'],
            (Goals item) => <String, Object?>{
                  'id': item.id,
                  'uuId': item.uuId,
                  'userId': item.userId,
                  'name': item.name,
                  'amountTarget': item.amountTarget,
                  'amount': item.amount,
                  'date': item.date,
                  'targetDate': item.targetDate,
                  'color': item.color,
                  'percentDone': item.percentDone,
                  'isDone': item.isDone ? 1 : 0,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Goals> _goalsInsertionAdapter;

  final UpdateAdapter<Goals> _goalsUpdateAdapter;

  final DeletionAdapter<Goals> _goalsDeletionAdapter;

  @override
  Future<Goals?> getById(int id) async {
    return _queryAdapter.query('Select * from goals where id= ?1',
        mapper: (Map<String, Object?> row) => Goals(
            id: row['id'] as int,
            uuId: row['uuId'] as String,
            userId: row['userId'] as String,
            name: row['name'] as String,
            amountTarget: row['amountTarget'] as double,
            amount: row['amount'] as double,
            targetDate: row['targetDate'] as String,
            date: row['date'] as String,
            isDone: (row['isDone'] as int) != 0,
            percentDone: row['percentDone'] as double?,
            color: row['color'] as String?,
            createAt: row['createAt'] as String?,
            updateAt: row['updateAt'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<Goals>> getAllGoals() async {
    return _queryAdapter.queryList('Select * from goals',
        mapper: (Map<String, Object?> row) => Goals(
            id: row['id'] as int,
            uuId: row['uuId'] as String,
            userId: row['userId'] as String,
            name: row['name'] as String,
            amountTarget: row['amountTarget'] as double,
            amount: row['amount'] as double,
            targetDate: row['targetDate'] as String,
            date: row['date'] as String,
            isDone: (row['isDone'] as int) != 0,
            percentDone: row['percentDone'] as double?,
            color: row['color'] as String?,
            createAt: row['createAt'] as String?,
            updateAt: row['updateAt'] as String?));
  }

  @override
  Future<List<Goals>> getAllGoalsIsOrNotDone(bool done) async {
    return _queryAdapter.queryList('Select * from goals where isDone= ?1',
        mapper: (Map<String, Object?> row) => Goals(
            id: row['id'] as int,
            uuId: row['uuId'] as String,
            userId: row['userId'] as String,
            name: row['name'] as String,
            amountTarget: row['amountTarget'] as double,
            amount: row['amount'] as double,
            targetDate: row['targetDate'] as String,
            date: row['date'] as String,
            isDone: (row['isDone'] as int) != 0,
            percentDone: row['percentDone'] as double?,
            color: row['color'] as String?,
            createAt: row['createAt'] as String?,
            updateAt: row['updateAt'] as String?),
        arguments: [done ? 1 : 0]);
  }

  @override
  Future<List<Goals>> getAllGoalsOfDate(String date) async {
    return _queryAdapter.queryList('Select * from goals where date=?1',
        mapper: (Map<String, Object?> row) => Goals(
            id: row['id'] as int,
            uuId: row['uuId'] as String,
            userId: row['userId'] as String,
            name: row['name'] as String,
            amountTarget: row['amountTarget'] as double,
            amount: row['amount'] as double,
            targetDate: row['targetDate'] as String,
            date: row['date'] as String,
            isDone: (row['isDone'] as int) != 0,
            percentDone: row['percentDone'] as double?,
            color: row['color'] as String?,
            createAt: row['createAt'] as String?,
            updateAt: row['updateAt'] as String?),
        arguments: [date]);
  }

  @override
  Future<int> insertItem(Goals item) {
    return _goalsInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Goals item) {
    return _goalsUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(Goals item) {
    return _goalsDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}

class _$DebtDao extends DebtDao {
  _$DebtDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _debtInsertionAdapter = InsertionAdapter(
            database,
            'debts',
            (Debt item) => <String, Object?>{
                  //'id': item.id,
                  'uuid': item.uuid,
                  'userId': item.userId,
                  'walletId': item.walletId,
                  'type': item.type,
                  'from': item.from,
                  'to': item.to,
                  'amountTarget': item.amountTarget,
                  'amount': item.amount,
                  'date': item.date,
                  'time': item.time,
                  'isDone': item.isDone ? 1 : 0,
                  'description': item.description,
                  'color': item.color,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _debtUpdateAdapter = UpdateAdapter(
            database,
            'debts',
            ['id'],
            (Debt item) => <String, Object?>{
                  'id': item.id,
                  'uuid': item.uuid,
                  'userId': item.userId,
                  'walletId': item.walletId,
                  'type': item.type,
                  'from': item.from,
                  'to': item.to,
                  'amountTarget': item.amountTarget,
                  'amount': item.amount,
                  'date': item.date,
                  'time': item.time,
                  'isDone': item.isDone ? 1 : 0,
                  'description': item.description,
                  'color': item.color,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                }),
        _debtDeletionAdapter = DeletionAdapter(
            database,
            'debts',
            ['id'],
            (Debt item) => <String, Object?>{
                  'id': item.id,
                  'uuid': item.uuid,
                  'userId': item.userId,
                  'walletId': item.walletId,
                  'type': item.type,
                  'from': item.from,
                  'to': item.to,
                  'amountTarget': item.amountTarget,
                  'amount': item.amount,
                  'date': item.date,
                  'time': item.time,
                  'isDone': item.isDone ? 1 : 0,
                  'description': item.description,
                  'color': item.color,
                  'createAt': item.createAt,
                  'updateAt': item.updateAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Debt> _debtInsertionAdapter;

  final UpdateAdapter<Debt> _debtUpdateAdapter;

  final DeletionAdapter<Debt> _debtDeletionAdapter;

  @override
  Future<Debt?> getById(int id) async {
    return _queryAdapter.query('Select * from debts where id= ?1',
        mapper: (Map<String, Object?> row) => Debt(
            id: row['id'] as int,
            uuid: row['uuid'] as String,
            userId: row['userId'] as String,
            walletId: row['walletId'] as String,
            type: row['type'] as String,
            from: row['from'] as String,
            to: row['to'] as String,
            amountTarget: row['amountTarget'] as double,
            amount: row['amount'] as double,
            date: row['date'] as String,
            time: row['time'] as String,
            description: row['description'] as String,
            color: row['color'] as String,
            isDone: (row['isDone'] as int) != 0,
            createAt: row['createAt'] as String,
            updateAt: row['updateAt'] as String),
        arguments: [id]);
  }

  @override
  Future<List<Debt>> getAllGoals() async {
    return _queryAdapter.queryList('Select * from debts',
        mapper: (Map<String, Object?> row) => Debt(
            id: row['id'] as int,
            uuid: row['uuid'] as String,
            userId: row['userId'] as String,
            walletId: row['walletId'] as String,
            type: row['type'] as String,
            from: row['from'] as String,
            to: row['to'] as String,
            amountTarget: row['amountTarget'] as double,
            amount: row['amount'] as double,
            date: row['date'] as String,
            time: row['time'] as String,
            description: row['description'] as String,
            color: row['color'] as String,
            isDone: (row['isDone'] as int) != 0,
            createAt: row['createAt'] as String,
            updateAt: row['updateAt'] as String));
  }

  @override
  Future<List<Debt>> getAllDebtIsOrNotDone({required bool isDone}) async {
    return _queryAdapter.queryList('Select * from debts where isDone= ?1',
        mapper: (Map<String, Object?> row) => Debt(
            id: row['id'] as int,
            uuid: row['uuid'] as String,
            userId: row['userId'] as String,
            walletId: row['walletId'] as String,
            type: row['type'] as String,
            from: row['from'] as String,
            to: row['to'] as String,
            amountTarget: row['amountTarget'] as double,
            amount: row['amount'] as double,
            date: row['date'] as String,
            time: row['time'] as String,
            description: row['description'] as String,
            color: row['color'] as String,
            isDone: (row['isDone'] as int) != 0,
            createAt: row['createAt'] as String,
            updateAt: row['updateAt'] as String),
        arguments: [isDone ? 1 : 0]);
  }

  @override
  Future<List<Debt>> getAllGoalsOfDate(String date) async {
    return _queryAdapter.queryList('Select * from debts where date=?1',
        mapper: (Map<String, Object?> row) => Debt(
            id: row['id'] as int,
            uuid: row['uuid'] as String,
            userId: row['userId'] as String,
            walletId: row['walletId'] as String,
            type: row['type'] as String,
            from: row['from'] as String,
            to: row['to'] as String,
            amountTarget: row['amountTarget'] as double,
            amount: row['amount'] as double,
            date: row['date'] as String,
            time: row['time'] as String,
            description: row['description'] as String,
            color: row['color'] as String,
            isDone: (row['isDone'] as int) != 0,
            createAt: row['createAt'] as String,
            updateAt: row['updateAt'] as String),
        arguments: [date]);
  }

  @override
  Future<int> insertItem(Debt item) {
    return _debtInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Debt item) {
    return _debtUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(Debt item) {
    return _debtDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}
