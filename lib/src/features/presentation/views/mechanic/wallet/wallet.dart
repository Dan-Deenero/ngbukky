import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ngbuka/src/config/keys/app_keys.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/domain/data/transaction_model.dart';
import 'package:ngbuka/src/domain/data/wallet_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/features/presentation/widgets/wallet_tile.dart';

import '../../../../../config/locator/app_locator.dart';

Widget transactionBox(String heading, String time) => Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          customText(
              text: heading, fontSize: 10, textColor: AppColors.textColor),
          heightSpace(1),
          customText(text: "₦0", fontSize: 24, textColor: AppColors.black),
          heightSpace(1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            // width: 35.w,
            height: 2.h,
            decoration: BoxDecoration(
                color: AppColors.containerGrey,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  BootstrapIcons.arrow_down,
                  color: AppColors.green,
                  size: 10,
                ),
                widthSpace(1),
                customText(
                    text: time, fontSize: 10, textColor: AppColors.black),
              ],
            ),
          ),
        ],
      ),
    );

class Wallet extends HookWidget {
  const Wallet({super.key});
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final wallet = useState<WalletModel?>(null);
    final isLoad = useState<bool>(true);

    getWallet() {
      mechanicRepo.getWallet().then(
        (value) {
          wallet.value = value;
          isLoad.value = false;
        },
      );
    }

    accept() {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: Container(
            // padding: EdgeInsets.all(10.0),
            width: 700, // Set the desired width
            height: 200,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                            text: 'Withdraw funds',
                            fontSize: 20,
                            textColor: AppColors.textGrey,
                            fontWeight: FontWeight.w500,
                            textAlignment: TextAlign.start),
                        InkWell(
                            onTap: () => context.pop(),
                            child: SvgPicture.asset(AppImages.cancelModal))
                      ],
                    ),
                  ),
                  heightSpace(1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        customText(
                          text: 'Set up your local bank account ',
                          fontSize: 12,
                          textColor: AppColors.black,
                          textAlignment: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  heightSpace(3),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                            context.push(AppRoutes.withdrawFunds);
                          },
                          child: customText(
                            text: 'Cancel',
                            fontSize: 16,
                            textColor: AppColors.textGrey,
                          ),
                        ),
                        widthSpace(3),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppColors.containerGrey,
                        ),
                        widthSpace(3),
                        TextButton(
                          onPressed: () {
                            context.pop();
                            context.push(AppRoutes.localAccountSetup);
                          },
                          child: customText(
                            text: 'Continue',
                            fontSize: 16,
                            textColor: AppColors.darkOrange,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    final transactionHistory = useState<List<TransactionModel>>([]);
    final isLoading = useState<bool>(true);
    getTransaction() {
      mechanicRepo.getAllTransaction('all').then(
        (value) {
          transactionHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getTransaction();
      getWallet();
      return null;
    }, [transactionHistory.value.length]);

    final tabIndex = useState<int>(0);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: AppColors.backgroundGrey,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                  text: "Wallet",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.black),
              // heightSpace(1),
              bodyText("View analytics and withdraw from your wallet")
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgPicture.asset(AppImages.notification),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    height: 20.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              AppImages.walletbase,
                            ))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customText(
                          text: "Total Balance",
                          fontSize: 15,
                          textColor: AppColors.white,
                        ),
                        isLoad.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : customText(
                                text: '₦${wallet.value!.balance}',
                                fontSize: 32,
                                textColor: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        heightSpace(1),
                        GestureDetector(
                          onTap: () {
                            final storedAccount = locator<LocalStorageService>()
                                .getDataFromDisk(AppKeys.accountNo);
                            

                            if (storedAccount == '' || storedAccount == null) {
                              accept();
                            } else {
                              context.push(AppRoutes.withdrawFunds);
                            }
                          },
                          child: SvgPicture.asset(AppImages.welcomeImage),
                        ),
                        // heightSpace(2),
                      ],
                    ),
                  ),
                  heightSpace(2),
                  SizedBox(
                    height: 14.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        transactionBox("Total Earnings", "This year"),
                        verticalDivide(),
                        transactionBox("Earned", "This month"),
                        verticalDivide(),
                        transactionBox("Withdrawn", "This month")
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                          text: "History",
                          fontSize: 15,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.bold),
                      if (transactionHistory.value.isEmpty)
                        IgnorePointer(
                          ignoring: true,
                          child: Row(
                            children: [
                              customText(
                                text: "See all",
                                fontSize: 15,
                                textColor: AppColors.primary.withOpacity(0.1),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: AppColors.primary.withOpacity(0.1),
                              )
                            ],
                          ),
                        )
                      else
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.walletHistory),
                          child: Row(
                            children: [
                              customText(
                                  text: "See all",
                                  fontSize: 15,
                                  textColor: AppColors.primary),
                              const Icon(
                                Icons.arrow_forward,
                                size: 20,
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
            heightSpace(3),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.borderGrey,
                  borderRadius: BorderRadius.circular(5)),
              child: TabBar(
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: AppColors.primary,
                labelColor: AppColors.primary,
                indicator: const BoxDecoration(),
                onTap: (value) {
                  tabIndex.value = value;
                },
                tabs: [
                  Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                        color: tabIndex.value == 0
                            ? AppColors.white
                            : AppColors.borderGrey,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Tab(
                      text: "Payment",
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                        color: tabIndex.value == 1
                            ? AppColors.white
                            : AppColors.borderGrey,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Tab(
                      text: "Withdrawal",
                    ),
                  ),
                ],
              ),
            ),
            heightSpace(2),
            const Expanded(
              child: TabBarView(
                children: [PaymentTab(), WithdrawalTab()],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Padding verticalDivide() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 35, top: 15),
      child: VerticalDivider(
        thickness: 1,
      ),
    );
  }
}

class PaymentTab extends HookWidget {
  const PaymentTab({super.key});
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final transactionHistory = useState<List<TransactionModel>>([]);
    final isLoading = useState<bool>(true);
    getTransaction() {
      mechanicRepo.getAllTransaction('credit').then(
        (value) {
          transactionHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getTransaction();
      return null;
    }, [transactionHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  if (transactionHistory.value.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.nopaymenticon),
                          heightSpace(1),
                          SizedBox(
                            width: 130,
                            child: customText(
                              text: 'No payments were made to you',
                              fontSize: 15,
                              textColor: AppColors.textGrey.withOpacity(0.3),
                              textAlignment: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  else
                    ...transactionHistory.value.map(
                      (e) {
                        var dateString = e.createdAt;
                        var dateTime = DateTime.parse(dateString!);
                        var formattedDate =
                            DateFormat('dd MMM yyyy').format(dateTime);

                        var formattedTime =
                            DateFormat('hh:mm a').format(dateTime);
                        return Column(
                          children: [
                            WalletTile(
                              id: e.id,
                              isWithdrawal: false,
                              isMechanic: true,
                              date: formattedDate,
                              amount: e.amount,
                              status: e.status,
                              time: formattedTime,
                            ),
                            heightSpace(2)
                          ],
                        );
                      },
                    )
                ],
              ),
            ),
          );
  }
}

class WithdrawalTab extends HookWidget {
  const WithdrawalTab({super.key});
  static final MechanicRepo mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final transactionHistory = useState<List<TransactionModel>>([]);
    final isLoading = useState<bool>(true);
    getTransaction() {
      mechanicRepo.getAllTransaction('debit').then(
        (value) {
          transactionHistory.value = value;
          isLoading.value = false;
        },
      );
    }

    useEffect(() {
      getTransaction();
      return null;
    }, [transactionHistory.value.length]);
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  if (transactionHistory.value.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.nopaymenticon),
                          heightSpace(1),
                          SizedBox(
                            width: 130,
                            child: customText(
                              text: 'No payments were made to you',
                              fontSize: 15,
                              textColor: AppColors.textGrey.withOpacity(0.3),
                              textAlignment: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  else
                    ...transactionHistory.value.map(
                      (e) {
                        var dateString = e.createdAt;
                        var dateTime = DateTime.parse(dateString!);
                        var formattedDate =
                            DateFormat('dd MMM yyyy').format(dateTime);

                        var formattedTime =
                            DateFormat('hh:mm a').format(dateTime);
                        return Column(
                          children: [
                            WalletTile(
                              id: e.id,
                              isWithdrawal: true,
                              isMechanic: true,
                              date: formattedDate,
                              amount: e.amount,
                              status: e.status,
                              time: formattedTime,
                            ),
                            heightSpace(2)
                          ],
                        );
                      },
                    )
                ],
              ),
            ),
          );
  }
}
