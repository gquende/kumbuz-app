import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:kumbuz/features/open_finance/domain/repository/i_bank_repository.dart';
import 'package:kumbuz/features/open_finance/domain/usecases/connect_account_usecase.dart';
import 'package:kumbuz/features/open_finance/domain/usecases/fetch_transaction_usecase.dart';
import 'package:kumbuz/features/open_finance/domain/usecases/get_bank_accounts.dart';
import 'package:kumbuz/features/open_finance/domain/usecases/save_bank_account_usecase.dart';
import 'package:kumbuz/features/sateva/data/data_source/remote/kixikila/kixikila_payments_firebase_datasource.dart';
import 'package:kumbuz/features/sateva/data/data_source/remote/users/user_remote_data_source.dart';
import 'package:kumbuz/features/sateva/data/repositories/notification_repository.dart';
import 'package:kumbuz/features/sateva/data/repositories/user_repository.dart';
import 'package:kumbuz/features/sateva/data/repositories/wallet_repository.dart';
import 'package:kumbuz/features/sateva/domain/repositories/expense/i_expense_repository.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_notification_repository.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_transaction_repository.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_user_repository.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_wallet_repository.dart';
import 'package:kumbuz/features/sateva/domain/usecases/expense_usecase/add_expense_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/kixikila_usecases/kixikila_insert_in_guest_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/transactions_usecase/get_sum_transaction_by_type.dart';
import 'package:kumbuz/features/sateva/domain/usecases/user_usecases/user_get_by_id_usecase.dart';
import 'package:kumbuz/features/sateva/presenter/pages/auth/controller/auth_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/controller/kixikila_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/notifications/controller/notification_controller.dart';

import '../../configs/config.dart';
import '../../features/open_finance/data/repositories/bank_repository.dart';
import '../../features/open_finance/domain/usecases/get_bank_account_by_name.dart';
import '../../features/open_finance/presenter/controllers/bank_controller.dart';
import '../../features/sateva/data/data_source/remote/kixikila/kixikila_firebase_datasource.dart';
import '../../features/sateva/data/data_source/remote/kixikila/kixikila_guest_firebase_datasource.dart';
import '../../features/sateva/data/repositories/debt_repository.dart';
import '../../features/sateva/data/repositories/expense_repository.dart';
import '../../features/sateva/data/repositories/income_repository.dart';
import '../../features/sateva/data/repositories/kixikila/kixikila_guest_repository.dart';
import '../../features/sateva/data/repositories/kixikila/kixikila_payments_repository.dart';
import '../../features/sateva/data/repositories/kixikila/kixikila_repository.dart';
import '../../features/sateva/data/repositories/transaction_repository.dart';
import '../../features/sateva/domain/repositories/i_debt_repository.dart';
import '../../features/sateva/domain/repositories/i_income_repository.dart';
import '../../features/sateva/domain/repositories/kixikila/i_kixikila_payment_repository.dart';
import '../../features/sateva/domain/repositories/kixikila/i_kixikila_user_repository.dart';
import '../../features/sateva/domain/repositories/kixikila/i_kixikilia_repository.dart';
import '../../features/sateva/domain/usecases/category_usecases.dart';
import '../../features/sateva/domain/usecases/controllers/expense_controlller.dart';
import '../../features/sateva/domain/usecases/expense_usecase/delete_expense_usecase.dart';
import '../../features/sateva/domain/usecases/expense_usecase/get_expense_by_id_usecase.dart';
import '../../features/sateva/domain/usecases/expense_usecase/update_expense_usecase.dart';
import '../../features/sateva/domain/usecases/income_usecases/add_income_usecase.dart';
import '../../features/sateva/domain/usecases/income_usecases/delete_expense_usecase.dart';
import '../../features/sateva/domain/usecases/income_usecases/get_income_by_id_usecase.dart';
import '../../features/sateva/domain/usecases/income_usecases/update_expense_usecase.dart';
import '../../features/sateva/domain/usecases/kixikila_usecases/guests/get_all_usecase.dart';
import '../../features/sateva/domain/usecases/kixikila_usecases/guests/insert_usecase.dart';
import '../../features/sateva/domain/usecases/kixikila_usecases/guests/update_usecase.dart';
import '../../features/sateva/domain/usecases/kixikila_usecases/kixikila_get_all_usecase.dart';
import '../../features/sateva/domain/usecases/kixikila_usecases/kixikila_insert_usecase.dart';
import '../../features/sateva/domain/usecases/kixikila_usecases/payments/get_all_usecase.dart';
import '../../features/sateva/domain/usecases/kixikila_usecases/payments/insert_usecase.dart';
import '../../features/sateva/domain/usecases/notification_usecases/send_notification_usecase.dart';
import '../../features/sateva/domain/usecases/transactions_usecase/delete_transactions.dart';
import '../../features/sateva/domain/usecases/transactions_usecase/get_transactions_by_type_item.dart';
import '../../features/sateva/domain/usecases/transactions_usecase/update_transaction_usecase.dart';
import '../../features/sateva/domain/usecases/user_usecases/user_create_usecase.dart';
import '../../features/sateva/domain/usecases/user_usecases/user_logout_usecase.dart';
import '../../features/sateva/domain/usecases/user_usecases/user_update_usecase.dart';
import '../../features/sateva/domain/usecases/wallet_usecases/get_wallet_by_type.dart';
import '../../features/sateva/presenter/pages/tips/controller/tips_controller.dart';
import '../../features/sateva/presenter/pages/transactions/controller/transaction_controller.dart';
import '../../services/dynamic_link_service.dart';
import '../../services/firebase_messagin_service.dart';
import '../../services/nordigen_service.dart';
import '../../services/notification_service.dart';
import '../../services/one_signal_service.dart';
import '../utils/navigation_service.dart';

final class DependencyInjection {
  static DependencyInjection? _instance;

  DependencyInjection._();

  factory DependencyInjection() => _instance ??= DependencyInjection._();

  Future<void> dispose() async {
    await GetIt.I.reset();
    _instance = null;
  }

  Future<void> setup() async {
    // await Firebase.initializeApp();
    var getIt = GetIt.instance;
    await dotenv.load();

    getIt.registerLazySingleton(() => ExpenseController());

    //Inject Remotes DataSource
    getIt.registerSingleton(KixikilaRemoteDataSource());
    getIt.registerSingleton(KixikilaGuestRemoteDataSource());
    getIt.registerSingleton(UserRemoteDataSource());
    getIt.registerSingleton(KixikilaPaymentsRemoteDataSource());

    //Inject Service
    getIt.registerSingleton(NotificationService());
    getIt.registerSingleton(NordigenClient(
        secret_id: dotenv.get('NORDIGEN_ID'),
        secret_key: dotenv.get('NORDIGEN_KEY')));
    getIt.registerLazySingleton(() => DynamicLinkService());
    getIt.registerLazySingleton(() => NavigationService());

    OneSignalService oneSignalService = OneSignalService(
        APP_KEY: dotenv.get("ONESIGNAL_APP_ID"),
        API_KEY: dotenv.get("ONESIGNAL_API_KEY"));

    getIt
        .registerLazySingleton(() => SendNotificationUsecase(oneSignalService));

    getIt.registerSingleton(
        FirebaseMessagingService(getIt.get<NotificationService>()));

    //Inject Repositories
    getIt.registerSingleton<IKixikilaRepository>(KixikilaRepository(
        remoteDataSource: getIt.get<KixikilaRemoteDataSource>()));

    getIt.registerSingleton<IKixikilaPaymentRepository>(
        KixikilaPaymentRepository(
            remoteDataSource: getIt.get<KixikilaPaymentsRemoteDataSource>()));

    getIt.registerSingleton<IKixikilaGuestRepository>(KixikilaUserRepository(
        remoteDataSource: getIt.get<KixikilaGuestRemoteDataSource>()));

    getIt.registerSingleton<IUserRepository>(UserRepository(
        getIt.get<UserRemoteDataSource>(),
        db: AppConfiguration.database));

    getIt.registerSingleton<INotificationRepository>(
        NotificationRepository(AppConfiguration.database));

    getIt.registerSingleton<IExpenseRepository>(
        ExpenseRepository(AppConfiguration.database));

    getIt.registerSingleton<IIncomeRepository>(
        IncomeRepository(AppConfiguration.database));

    getIt.registerSingleton<IDebtRepository>(
        DebtRepository(AppConfiguration.database));

    getIt.registerSingleton<IWalletRepository>(
        WalletRepository(AppConfiguration.database));

    getIt.registerSingleton<IBankRepository>(
        BankRepository(AppConfiguration.database));

    getIt.registerSingleton<ITransactionRepository>(
        TransactionRepository(AppConfiguration.database));

    /*
    ====  Inject Usecases ====
    */
    getIt.registerSingleton(
        KixikilaInsertUsecase(repository: getIt.get<IKixikilaRepository>()));

    getIt.registerSingleton(KixikilaInsertInTheGuestUsecase(
        repository: getIt.get<IKixikilaRepository>()));
    getIt.registerSingleton(
        KixikilaGetAllUsecase(repository: getIt.get<IKixikilaRepository>()));

    getIt.registerSingleton(KixikilaPaymentGetAllUsecase(
        repository: getIt.get<IKixikilaPaymentRepository>()));

    getIt.registerSingleton(KixikilaPaymentInsertUsecase(
        repository: getIt.get<IKixikilaPaymentRepository>()));

    getIt.registerSingleton(
        UserCreateUsecase(repository: getIt.get<IUserRepository>()));

    getIt.registerSingleton(AddExpenseUsecase(getIt.get<IExpenseRepository>()));
    getIt.registerSingleton(
        GetExpenseByIDUsecase(getIt.get<IExpenseRepository>()));
    getIt.registerSingleton(
        UpdateExpenseUsecase(getIt.get<IExpenseRepository>()));
    getIt.registerSingleton(
        DeleteExpenseUsecase(getIt.get<IExpenseRepository>()));

    getIt.registerSingleton(AddIncomeUsecase(getIt.get<IIncomeRepository>()));
    getIt.registerSingleton(
        GetIncomeByIDUsecase(getIt.get<IIncomeRepository>()));
    getIt
        .registerSingleton(UpdateIncomeUsecase(getIt.get<IIncomeRepository>()));
    getIt
        .registerSingleton(DeleteIncomeUsecase(getIt.get<IIncomeRepository>()));

    getIt.registerSingleton(
        UserLogoutUsecase(repository: getIt.get<IUserRepository>()));

    getIt.registerSingleton(
        UserGetByIdUsecase(repository: getIt.get<IUserRepository>()));
    getIt.registerSingleton(
        UserUpdateUsecase(repository: getIt.get<IUserRepository>()));

    getIt.registerSingleton(KixikilaGuestGetAllUsecase(
        repository: getIt.get<IKixikilaGuestRepository>()));

    getIt.registerSingleton(KixikilaGuestInsertUsecase(
        repository: getIt.get<IKixikilaGuestRepository>()));

    getIt.registerSingleton(KixikilaGuestUpdateUsecase(
        repository: getIt.get<IKixikilaGuestRepository>()));

    getIt.registerLazySingleton(
        () => CategoryUsecases(AppConfiguration.database));

    getIt.registerSingleton(GetBankAccounts(getIt.get<IBankRepository>()));
    getIt.registerSingleton(GetBankAccountByName(getIt.get<IBankRepository>()));
    getIt.registerSingleton(SaveBankAccount(getIt.get<IBankRepository>()));
    getIt.registerSingleton(GetWalletByType(getIt.get<IWalletRepository>()));

    getIt.registerSingleton(
        GetSumAmountTransactionByType(getIt.get<ITransactionRepository>()));

    getIt.registerSingleton(
        DeleteTransactionUsecase(getIt.get<ITransactionRepository>()));

    getIt.registerSingleton(
        UpdateTransactionUsecase(getIt.get<ITransactionRepository>()));

    getIt.registerSingleton(
        GetTransactionsByTypeItem(getIt.get<ITransactionRepository>()));

    getIt.registerSingleton(ConnectAccountUsecase(
        getIt.get<NordigenClient>(), dotenv.get('INSTITUTION_ID')));

    getIt.registerSingleton(FetchTransactionUsecase(
        getIt.get<NordigenClient>(), dotenv.get('INSTITUTION_ID')));

    //getIt.registerSingleton(KixikilaGetAllUsecase(repository: getIt.get<IKixikilaRepository>()));

    //Inject Controllers
    getIt.registerSingleton(KixikilaController());
    getIt.registerSingleton(AuthController());
    getIt.registerSingleton(TipsController());
    getIt.registerSingleton(NotificationController());
    getIt.registerSingleton(TransactionController());
    getIt.registerSingleton(BankController(
        getIt.get<NordigenClient>(), dotenv.get('INSTITUTION_ID')));
  }
}

abstract class DI {
  static T get<T extends Object>() => GetIt.I.get<T>();
}
