import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngbuka/src/config/keys/app_keys.dart';
import 'package:ngbuka/src/config/services/api/api_client.dart';
import 'package:ngbuka/src/config/services/api/endpoints.dart';
import 'package:ngbuka/src/config/services/api/payment_client.dart';
import 'package:ngbuka/src/domain/data/account.dart';
import 'package:ngbuka/src/domain/data/account_name_model.dart';
import 'package:ngbuka/src/domain/data/city_lga.dart';
import 'package:ngbuka/src/domain/data/dealer_dashboard_model.dart';
import 'package:ngbuka/src/domain/data/get_account.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/inventory_model.dart';
import 'package:ngbuka/src/domain/data/notification_model.dart';
import 'package:ngbuka/src/domain/data/orders_model.dart';
import 'package:ngbuka/src/domain/data/price_markup.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/data/services_model.dart';
import 'package:ngbuka/src/domain/data/statistics_for_quote.dart';
import 'package:ngbuka/src/domain/data/statistics_model.dart';
import 'package:ngbuka/src/domain/data/transaction_model.dart';
import 'package:ngbuka/src/domain/data/user_model.dart';
import 'package:ngbuka/src/domain/data/wallet_model.dart';

import '../../config/locator/app_locator.dart';
import '../../config/services/storage_service.dart';

class MechanicRepo {
  Future<bool> acceptOrRejectBooking(Map<String, String> body, id) async {
    final response = await ApiClient.patch('${Endpoints.getAllBooking}/$id',
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> acceptOrRejectQuote(Map<String, String> body, id) async {
    final response = await ApiClient.patch('${Endpoints.getAllQuotes}/$id',
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> addPersonalizedService(Map<dynamic, dynamic> body) async {
    final response = await ApiClient.post(Endpoints.addPersonalizedService,
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<List<BookingModel>> getAllBooking(String status) async {
    final response = await ApiClient.get(
        '${Endpoints.getAllBooking}?status=$status',
        useToken: true);
    List<BookingModel> booking = [];
    if (response.status == 200) {
      for (var bookingModel in response.entity['rows']) {
        booking.add(BookingModel.fromJson(bookingModel));
      }
      return booking;
    }
    return booking;
  }

  Future<List<QuotesModel>> getAllQuotes(String status) async {
    final response = await ApiClient.get(
        '${Endpoints.getAllQuotes}?status=$status',
        useToken: true);
    List<QuotesModel> quote = [];
    if (response.status == 200) {
      for (var quoteModel in response.entity['rows']) {
        quote.add(QuotesModel.fromJson(quoteModel));
      }
      return quote;
    } else if (response.status == 404) {
      return [];
    }
    return quote;
  }

  Future<MechanicServicesModel> getMechanicProfile() async {
    final response =
        await ApiClient.get(Endpoints.getMechanicServices, useToken: true);
    if (response.status == 200) {
      return MechanicServicesModel.fromJson(response.entity);
    }
    return MechanicServicesModel();
  }

  Future<BookingModel> getoneBooking(id) async {
    final response =
        await ApiClient.get('${Endpoints.getAllBooking}/$id', useToken: true);
    if (response.status == 200) {
      log(response.entity.toString());
      return BookingModel.fromJson(response.entity);
    }
    return BookingModel();
  }

  Future<QuotesModel> getoneQuote(id) async {
    final response =
        await ApiClient.get('${Endpoints.getAllQuotes}/$id', useToken: true);
    if (response.status == 200) {
      log(response.entity.toString());
      return QuotesModel.fromJson(response.entity);
    }
    return QuotesModel();
  }

  Future<List<States>> getState() async {
    String endpoint = Endpoints.getState;
    final response = await ApiClient.get(endpoint, useToken: true);
    List<States> state = [];
    if (response.status == 200) {
      for(var stateModel in response.entity['data']){
        state.add(States.fromJson(stateModel));
      }
      return state;
    }
    return state;
  }

  Future<CityLGA> getSubdomain(String state) async {
    String endpoint = "${Endpoints.getLocation}?slug=$state";
    final response = await ApiClient.get(endpoint, useToken: true);
    if (response.status == 200) {
      return CityLGA.fromJson(response.entity);
    }
    return CityLGA();
  }

  Future<StatisticsModelForQuote> getAllStatisticsInfo() async {
    final response =
        await ApiClient.get(Endpoints.getStatisticsInfo, useToken: true);
    if (response.status == 200) {
      return StatisticsModelForQuote.fromJson(response.entity);
    }
    return StatisticsModelForQuote();
  }

  Future<StatisticsModelForQuote> getQuoteStatisticsInfo() async {
    final response = await ApiClient.get(
        '${Endpoints.getStatisticsInfo}?type=quote-request',
        useToken: true);
    if (response.status == 200) {
      return StatisticsModelForQuote.fromJson(response.entity);
    }
    return StatisticsModelForQuote();
  }

  Future<StatisticsModel> getBookingStatisticsInfo() async {
    final response = await ApiClient.get(
        '${Endpoints.getStatisticsInfo}?type=booking',
        useToken: true);
    if (response.status == 200) {
      return StatisticsModel.fromJson(response.entity);
    }
    return StatisticsModel();
  }

  Future<bool> markInspection(Map<String, String> body, id) async {
    final response = await ApiClient.patch(
        '${Endpoints.getAllBooking}/$id/finish',
        body: body,
        useToken: true);
    if (response.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> markInspectionAsCompleted(Map<String, String> body, id) async {
    final response = await ApiClient.patch(
        '${Endpoints.getAllBooking}/$id/complete',
        body: body,
        useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> markQuoteAsCompleted(Map<String, String> body, id) async {
    final response = await ApiClient.patch(
        '${Endpoints.getAllQuotes}/$id/complete',
        body: body,
        useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> saveProfileImage(Map<String, dynamic> data) async {
    final response =
        await ApiClient.put(Endpoints.mechanicProfileImage, body: data);
    if (response.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendQuoteForBooking(Map<dynamic, dynamic> body, id) async {
    final response = await ApiClient.post(
        '${Endpoints.getAllBooking}/$id/quote',
        body: body,
        useToken: false);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> sendQuoteForQuotes(Map<dynamic, dynamic> body, id) async {
    final response = await ApiClient.post('${Endpoints.getAllQuotes}/$id/quote',
        body: body, useToken: false);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> updateBusinessInfo(Map<String, dynamic> data) async {
    final response = await ApiClient.put(Endpoints.updateBusiness, body: data);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    final response = await ApiClient.get(
        '${Endpoints.getAllNotifications}?type=unseen',
        useToken: true);
    List<NotificationModel> notification = [];
    if (response.status == 200) {
      for (var notificationModel in response.entity['rows']) {
        notification.add(NotificationModel.fromJson(notificationModel));
      }
      return notification;
    }
    return notification;
  }

  Future<List<NotificationModel>> getAllSeenNotifications() async {
    final response = await ApiClient.get(
        '${Endpoints.getAllNotifications}?type=seen',
        useToken: true);
    List<NotificationModel> notification = [];
    if (response.status == 200) {
      for (var notificationModel in response.entity['rows']) {
        notification.add(NotificationModel.fromJson(notificationModel));
      }
      return notification;
    }
    return notification;
  }

  Future<NotificationModel> getOneNotification(id) async {
    final response = await ApiClient.get('${Endpoints.getAllNotifications}/$id',
        useToken: true);
    if (response.status == 200) {
      log(response.entity.toString());
      return NotificationModel.fromJson(response.entity);
    }
    return NotificationModel();
  }

  Future<List<BookingModel>> get5bookingAlert(String status) async {
    final response = await ApiClient.get(
        '${Endpoints.getAllBooking}?status=$status&limit=5',
        useToken: true);
    List<BookingModel> booking = [];
    if (response.status == 200) {
      for (var bookingModel in response.entity['rows']) {
        booking.add(BookingModel.fromJson(bookingModel));
      }
      return booking;
    }
    return booking;
  }

  Future<List<QuotesModel>> get5QuotesAlert(String status) async {
    final response = await ApiClient.get(
        '${Endpoints.getAllQuotes}?status=$status&limit=5',
        useToken: true);
    List<QuotesModel> quote = [];
    if (response.status == 200) {
      for (var quoteModel in response.entity['rows']) {
        quote.add(QuotesModel.fromJson(quoteModel));
      }
      return quote;
    }
    return quote;
  }

  Future<bool> reportClient(Map<dynamic, dynamic> body) async {
    final response = await ApiClient.post(Endpoints.reportClient,
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> updateDealerProfile(Map<String, dynamic> data, int level) async {
    final response = await ApiClient.put(
        '${Endpoints.updateDealerStoreProfile}?level=$level',
        body: data);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<UserModel> getDealerProfile() async {
    final response =
        await ApiClient.get(Endpoints.getDealerProfile, useToken: true);
    if (response.status == 200) {
      // log(response.entity);
      return UserModel.fromJson(response.entity);
    }
    return UserModel();
  }

  Future<List<InventoryModel>> getAllInventory(String status) async {
    final response = await ApiClient.get(
        '${Endpoints.dealerSparePart}?&inventory=$status',
        useToken: true);
    List<InventoryModel> inventory = [];
    if (response.status == 200) {
      for (var inventoryModel in response.entity['rows']) {
        inventory.add(InventoryModel.fromJson(inventoryModel));
      }
      return inventory;
    }
    return inventory;
  }

  Future<List<InventoryModel>> searchAnyInventory(String keyword) async {
    final response = await ApiClient.get(
        '${Endpoints.dealerSparePart}/search?q=$keyword',
        useToken: true);
    List<InventoryModel> inventory = [];
    if (response.status == 200) {
      for (var inventoryModel in response.entity['rows']) {
        inventory.add(InventoryModel.fromJson(inventoryModel));
      }
      return inventory;
    }
    return inventory;
  }

  Future<InventoryModel> getOneInventory(id) async {
    final response =
        await ApiClient.get('${Endpoints.dealerSparePart}/$id', useToken: true);
    if (response.status == 200) {
      log(response.entity.toString());
      return InventoryModel.fromJson(response.entity);
    }
    return InventoryModel();
  }

  Future<bool> addInventory(Map<dynamic, dynamic> body) async {
    final response = await ApiClient.post(Endpoints.dealerSparePart,
        body: body, useToken: true);
    if (response.status == 200 || response.status == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateInventory(Map<String, dynamic> data, id) async {
    final response = await ApiClient.put('${Endpoints.dealerSparePart}/$id',
        body: data, useToken: true);
    if (response.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteInventory(id) async {
    final response = await ApiClient.delete(
      '${Endpoints.dealerSparePart}/$id',
      useToken: true,
    );
    if (response.status == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<OrdersModel>> getAllOrder(String? status) async {
    final response = await ApiClient.get(
        '${Endpoints.dealerOrders}?&type=$status',
        useToken: true);
    List<OrdersModel> orders = [];
    if (response.status == 200) {
      for (var ordersModel in response.entity['rows']) {
        orders.add(OrdersModel.fromJson(ordersModel));
      }
      return orders;
    }
    return orders;
  }

  Future<OrdersModel> getOneOrder(id) async {
    final response =
        await ApiClient.get('${Endpoints.dealerOrders}/$id', useToken: true);
    if (response.status == 200) {
      log(response.entity.toString());
      return OrdersModel.fromJson(response.entity);
    }
    return OrdersModel();
  }

  Future<bool> processOrder(Map<String, String> body, id) async {
    final response = await ApiClient.patch('${Endpoints.dealerOrders}/$id',
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> confirmPickup(Map<String, String> body, id) async {
    final response = await ApiClient.patch(
        '${Endpoints.dealerOrders}/$id/confirm-pickup',
        body: body,
        useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<List<TransactionModel>> getAllTransaction(String? type) async {
    final response = await ApiClient.get(
        '${Endpoints.transactions}?&type=$type',
        useToken: true);
    List<TransactionModel> transaction = [];
    if (response.status == 200) {
      for (var transactionModel in response.entity['rows']) {
        transaction.add(TransactionModel.fromJson(transactionModel));
      }
      return transaction;
    }
    return transaction;
  }

  Future<TransactionModel> getOneTransaction(id) async {
    final response =
        await ApiClient.get('${Endpoints.transactions}/$id', useToken: true);
    if (response.status == 200) {
      log(response.entity.toString());
      return TransactionModel.fromJson(response.entity);
    }
    return TransactionModel();
  }

  Future<DashboardModel> getDealerDahsboardInfo() async {
    final response =
        await ApiClient.get(Endpoints.dealerDashboard, useToken: true);
        log(Endpoints.dealerDashboard);
    if (response.status == 200) {
      return DashboardModel.fromJson(response.entity);
    }
    return DashboardModel();
  }

  Future<bool> addAccount(Map<dynamic, dynamic> body, String password) async {
    final storedPassword =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.mechPassword);

    if (storedPassword == password) {
      final response =
          await ApiClient.post(Endpoints.account, body: body, useToken: true);
      if (response.status == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> addAccountDealer(
      Map<dynamic, dynamic> body, String password) async {
    final storedPassword =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.dealerPassword);

    if (storedPassword == password) {
      final response =
          await ApiClient.post(Endpoints.account, body: body, useToken: true);
      if (response.status == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<List<Account>> getAllBank() async {
    final response = await PaymentClient.get(
        '${Endpoints.getBankList}?&country=nigeria',
        useToken: true);
    List<Account> account = [];
    if (response.status == true) {
      for (var accountModel in response.data) {
        account.add(Account.fromJson(accountModel));
      }
      return account;
    }
    return account;
  }

  Future<GetAccount> getAccount() async {
    final response = await ApiClient.get(Endpoints.account, useToken: true);
    if (response.status == 200) {
      return GetAccount.fromJson(response.entity);
    }
    return GetAccount();
  }

  Future<AccountName> getAccountOwner(acctNo, bankCode) async {
    final response = await PaymentClient.get(
        '${Endpoints.getBankList}/resolve?account_number=$acctNo&bank_code=$bankCode',
        useToken: true);
    if (response.status == true) {
      String message = response.message ?? '';

      if (message.toLowerCase() == 'account number resolved') {
        return AccountName.fromJson(response.data);
      } else {
        // Handle incorrect account number scenario
        // You can throw an exception, return a special object, or handle it based on your requirements.
        throw Exception("Invalid account number");
      }
    }
    return AccountName();
  }

  Future<bool> withdrawFunds(
      Map<dynamic, dynamic> body, String password) async {
    final storedPassword =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.mechPassword);

    if (storedPassword == password) {
      final response = await ApiClient.post(Endpoints.walletWithdraw,
          body: body, useToken: true);
      if (response.status == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> withdrawFundsDealer(
      Map<dynamic, dynamic> body, String password) async {
    final storedPassword =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.dealerPassword);

    if (storedPassword == password) {
      final response = await ApiClient.post(Endpoints.walletWithdraw,
          body: body, useToken: true);
      if (response.status == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<WalletModel> getWallet() async {
    final response = await ApiClient.get(Endpoints.wallet, useToken: true);
    if (response.status == 200) {
      return WalletModel.fromJson(response.entity);
    }
    return WalletModel();
  }

  Future<bool> contactSupport(Map<dynamic, dynamic> body) async {
    final response =
        await ApiClient.post(Endpoints.contact, body: body, useToken: true);
    if (response.status == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PriceMarkup>> getPriceMarkups() async {
    final response =
        await ApiClient.get(Endpoints.priceMarkups, useToken: true);
    List<PriceMarkup> markup = [];
    if (response.status == 200) {
      for (var mup in response.entity) {
        markup.add(PriceMarkup.fromJson(mup));
      }
      return markup;
    }
    return markup;
  }
}

final allProvider = Provider<MechanicRepo>((ref) => MechanicRepo());
