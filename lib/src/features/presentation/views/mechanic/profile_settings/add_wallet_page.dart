import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/domain/data/account.dart';
import 'package:ngbuka/src/domain/data/account_name_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/success_modal.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_button.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_textformfield.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';
import 'package:ngbuka/src/utils/helpers/validators.dart';
import '../../../../../core/shared/colors.dart';

class AddWalletPage extends ConsumerStatefulWidget {
  const AddWalletPage({super.key});

  @override
  ConsumerState<AddWalletPage> createState() => _AddWalletPageState();
}

class _AddWalletPageState extends ConsumerState<AddWalletPage> {
  // const AddWalletPage({super.key});
  static final accountNumber = TextEditingController();
  static final password = TextEditingController();
  static final bankController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = true;
  bool isValidated = false;
  final MechanicRepo _mechanicRepo = MechanicRepo();
  String? selectedBank;
  String? acctName;
  String? code;
  List<Account> _bank = [];

  getAllBanks() {
    _mechanicRepo.getAllBank().then(
          (value) => setState(
            () {
              _bank = value;
              isLoading = false;
            },
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    getAllBanks();
  }

  showSuccesModal() async {
    await showDialog(
      context: context,
      builder: (context) => SuccessDialogue(
        title: 'Account Saved',
        subtitle:
            'Your local account number and bank has been saved, you can go ahead and withdraw now',
        action: () {
          context.pop();
        },
      ),
    );
  }

  saveAccount() async {
    var data = {"accountNumber": accountNumber.text, "bankCode": code};

    bool result = await _mechanicRepo.addAccount(data, password.text);
    log(result.toString());

    if (result) {
      showSuccesModal();
      password.clear();
      accountNumber.clear();
      bankController.clear();
    }
  }

  bool isFetchingAccountName = false;
  Color colos = AppColors.green;

  getAccountOwner() async {
    try {
      setState(() {
        isFetchingAccountName = true;
      });
      AccountName value =
          await _mechanicRepo.getAccountOwner(accountNumber.text, code);

      setState(() {
        acctName = value.accountName;
        colos = AppColors.green;
        isFetchingAccountName = false;
      });
    } catch (e) {
      // Handle the exception here
      setState(() {
        acctName = 'Invalid account';
        colos = AppColors.red;
        isFetchingAccountName = false;
      });
      // You can display an error message or handle it in any way suitable for your UI
    }
  }

  @override
  Widget build(BuildContext context) {
    showBankList() {
      List<Account> filteredBanks = [];
      bool isSearching = false;
      getAllBanks();
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Consumer(builder: (context, ref, _) {
              return Form(
                key: formKey,
                child: Container(
                  color: AppColors.backgroundGrey,
                  padding: const EdgeInsets.all(20),
                  height: 600,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                    text: "Select bank",
                                    fontSize: 18,
                                    textColor: AppColors.black,
                                    fontWeight: FontWeight.bold),
                                heightSpace(1),
                                customText(
                                  text: "bank",
                                  fontSize: 14,
                                  textColor: AppColors.textColor,
                                ),
                              ],
                            ),
                            InkWell(
                              child: SvgPicture.asset(AppImages.cancelModal),
                              onTap: () => context.pop(),
                            ),
                          ],
                        ),
                        heightSpace(5),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              isSearching = true;
                              filteredBanks = _bank
                                  .where((bank) => bank.name!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                          cursorColor: AppColors.black,
                          cursorWidth: 1,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            disabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.textformGrey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.textformGrey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            contentPadding:
                                const EdgeInsets.only(left: 10, top: 10),
                            errorStyle: const TextStyle(fontSize: 14),
                            hintText: 'search for your products',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.textGrey.withOpacity(0.3)),
                            prefixIcon: const Icon(Icons.search),
                            fillColor: AppColors.backgroundGrey,
                            filled: true,
                            enabledBorder: AppColors.emptyBorder,
                            errorBorder: AppColors.errorBorder,
                            focusedBorder: AppColors.normalBorder,
                            focusedErrorBorder: AppColors.normalBorder,
                          ),
                        ),
                        heightSpace(2),
                        Column(
                          children: [
                            ...(isSearching ? filteredBanks : _bank).map(
                              (bank) {
                                log(bank.name.toString());

                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context.pop(bankController.text);
                                        setState(() {
                                          selectedBank = bank.name;
                                          bankController.text = bank.name!;
                                          code = bank.code;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: 10.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ListTile(
                                          leading: SvgPicture.asset(
                                              AppImages.accountDet),
                                          title: customText(
                                            text: bank.name!,
                                            fontSize: 16,
                                            textColor: AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    heightSpace(2)
                                  ],
                                );
                              },
                            ),
                            heightSpace(2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: 25.h,
                decoration: const BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                        password.clear();
                        accountNumber.clear();
                        setState(() {
                          bankController.text = '';
                        });
                      },
                      child: Container(
                        height: 10.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(.5),
                            shape: BoxShape.circle),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 7.0),
                          child: Center(
                              child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                          )),
                        ),
                      ),
                    ),
                    heightSpace(1),
                    customText(
                        text: "Withdrawal details",
                        fontSize: 20,
                        textColor: AppColors.white),
                    heightSpace(1),
                    customText(
                        text: "Edit your bank and card details here",
                        fontSize: 15,
                        textColor: AppColors.white),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        heightSpace(3),
                        GestureDetector(
                          onTap: showBankList,
                          child: CustomTextFormField(
                            isDropdown: true,
                            isEnabled: false,
                            textEditingController: bankController,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: SvgPicture.asset(
                                AppImages.accountDet,
                              ),
                            ),
                            label: "Bank",
                            hintText: "select Bank",
                          ),
                        ),
                        heightSpace(1),
                        CustomTextFormField(
                          onChanged: (value) {
                            if (value.length == 10) {
                              getAccountOwner();
                            }
                          },
                          keyboardType: TextInputType.number,
                          validator: numericValidation,
                          textEditingController: accountNumber,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SvgPicture.asset(
                              AppImages.accountDet,
                            ),
                          ),
                          label: "Account Number",
                          hintText: "Type in business registration number",
                        ),
                        if (acctName == null)
                          const SizedBox.shrink()
                        else
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    customText(
                                      text: acctName!,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      textColor: colos,
                                      textAlignment: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        heightSpace(3),
                        CustomTextFormField(
                          isEnabled: acctName == null ? false : true,
                          onChanged: (value) {
                            if (value.length >= 6) {
                              setState(() {
                                isValidated = true;
                              });
                            } else {
                              setState(() {
                                isValidated = false;
                              });
                            }
                          },
                          isPassword: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SvgPicture.asset(
                              AppImages.passwordIcon,
                            ),
                          ),
                          textEditingController: password,
                          label: "Your Ngbuka login password",
                          validator: passwordValidation,
                          hintText: "Enter password",
                        ),
                        heightSpace(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.87,
                                  child: AppButton(
                                    isActive: isValidated,
                                    onTap: saveAccount,
                                    buttonText: "Save",
                                    isOrange: true,
                                    isSmall: true,
                                  ),
                                ),
                              ],
                            ),
                            heightSpace(2),
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.info),
                                widthSpace(2),
                                Flexible(
                                  child: bodyText(
                                      "You can always edit every information entered and saved later if you want"),
                                )
                              ],
                            ),
                            heightSpace(3),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isFetchingAccountName)
            Container(
              color: Colors.black.withOpacity(0.7), // Adjust opacity as needed
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
