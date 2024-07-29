import 'package:flutter/material.dart';
import 'package:ngbuka/src/core/shared/colors.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

showTermsPolicyDesclaimer(context) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Column(
              children: [
                customText(
                  text: "Privacy Policy for Sellers on Ngbuka",
                  fontSize: 15,
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                buildPolicySection(
                  header: '1. Introduction',
                  body:
                      'Ngbuka ("we," "us," "our") is committed to protecting the privacy of our sellers and mechanics ("you," "your"). This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our website and app to sell car spare parts or offer mechanic services.',
                ),
                buildPolicySection(
                  header: '2. Information We Collect',
                  body:
                      'We may collect information about you in the following ways:',
                ),
                buildPolicySection(
                  header: '2.1 Personal Data',
                  body:
                      'Personally identifiable information, such as your name, business name, shipping address, email address, telephone number, and demographic information, such as your age, gender, and interests, that you voluntarily provide to us when you register on the platform or use our services.',
                ),
                buildPolicySection(
                  header: '2.2 Business Data',
                  body:
                      'Information related to your business, such as your business registration details, tax identification number, product inventory, service descriptions, and pricing information.',
                ),
                buildPolicySection(
                  header: '2.3 Financial Data',
                  body:
                      'Financial information, such as data related to your payment method (e.g., valid credit card number, bank account details) and transactions made through the platform. We store only limited financial information.',
                ),
                buildPolicySection(
                  header: '2.4 Transaction Data',
                  body:
                      'Details about payments to and from you and other details of products and services you have sold or provided through the platform.',
                ),
                buildPolicySection(
                  header: '2.5 Technical Data',
                  body:
                      'Information about your access and use of our website or app, including your IP address, browser type, operating system, access times, and the pages you have viewed directly before and after accessing the website or app.',
                ),
                buildPolicySection(
                  header: '3. How We Use Your Information',
                  body:
                      'We use the information we collect in various ways, including to:\n'
                      '1. Provide, operate, and maintain our platform and services.\n'
                      '2. Improve, personalize, and expand our platform and services.\n'
                      '3. Understand and analyze how you use our platform and services.\n'
                      '4. Process your transactions and manage your orders.\n'
                      '5. Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the platform, and for marketing and promotional purposes.\n'
                      '6. Send you emails and text messages.\n'
                      '7. Detect and prevent fraud.\n'
                      '8. Comply with legal obligations.',
                ),
                buildPolicySection(
                  header: '4. Disclosure of Your Information',
                  body:
                      'We may share information we have collected about you in certain situations. Your information may be disclosed as follows:\n'
                      'By Law or to Protect Rights\n'
                      'If we believe the release of information about you is necessary to respond to legal process, to investigate or remedy potential violations of our policies, or to protect the rights, property, and safety of others, we may share your information as permitted or required by any applicable law, rule, or regulation.\n\n'
                      '2. Business Transfers\n'
                      'We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company.\n\n'
                      '3. With Your Consent\n'
                      'We may disclose your personal information for any other purpose with your consent.',
                ),
                buildPolicySection(
                  header: '5. Security of Your Information',
                  body:
                      'We use administrative, technical, and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable, and no method of data transmission can be guaranteed against any interception or other type of misuse.',
                ),
                buildPolicySection(
                  header: '6. Your Data Protection Rights',
                  body:
                      'Depending on your location, you may have the following rights regarding your personal data:\n\n'
                      '1. The right to access – You have the right to request copies of your personal data.\n'
                      '2. The right to rectification – You have the right to request that we correct any information you believe is inaccurate or complete information you believe is incomplete.',
                ),
                buildPolicySection(
                  header: 'Contact us',
                  body: 'If you have any questions, Please contact us at:\n'
                      'Email: info@ngbuka.com.ng\n'
                      'Phone: 07073042235\n'
                      'Address: Km 16 East/West Road Rumuosi, Port Harcourt, Rivers State',
                ),
                heightSpace(15),
                customText(
                  text: "Terms & Conditions for Seller Center Ngbuka",
                  fontSize: 15,
                  textColor: AppColors.orange,
                  fontWeight: FontWeight.bold,
                  textAlignment: TextAlign.center
                ),
                const SizedBox(height: 10),
                buildPolicySection(
                  header: '1. Scope',
                  body:
                      '1. Ngbuka (“Ngbuka”) owns and operates a platform in Nigeria that allows merchants to sell car spare parts and offer mechanic services to the public over the internet. This platform is provided through the website and app.\n'
                      '2. Merchants can sell their products on the Ngbuka platform. Ngbuka is entitled to accept purchases on behalf of the seller. Ngbuka\'s service is limited to referring customers to the merchant, accepting orders, and processing payments on their behalf. Ngbuka may also provide merchants with performance analytics and additional marketing support, reflective of the agreed level of commission.\n'
                      '3. Merchants authorize Ngbuka to accept binding orders from customers on their behalf. Ngbuka may change the website or service, or suspend the service, without notice.',
                ),
                buildPolicySection(
                  header: '2. Ngbuka\'s Rights and Obligations',
                  body:
                      '1. The relationship between customers and Ngbuka is governed by Ngbuka\'s privacy policy and general terms and conditions, both available on the website.\n'
                      '2. Ngbuka will present the products listed by the seller on its platform. Merchants are responsible for listing their own products.\n'
                      '3. Ngbuka is authorized to accept binding sales on behalf of the merchant and will ensure order data is passed on to the merchant as efficiently as possible.\n'
                      '4. To maintain quality and high standards, Ngbuka reserves the right to terminate the relationship with a merchant if they repeatedly receive bad reviews or complaints, or fail to comply with recommendations.',
                ),
                buildPolicySection(
                  header: '3. Merchant\'s Rights and Obligations',
                  body:
                      '1. Merchants must provide all necessary information when listing a product on Ngbuka. This includes a detailed title, sub-title, price, quantity, picture, and description. Misrepresentation is prohibited. Merchants must notify Ngbuka of any changes to their listings.\n'
                      '2. Merchants guarantee that their product information complies with all legal requirements, including consumer protection.\n'
                      '3. Merchants are responsible for maintaining up-to-date inventory on Ngbuka.\n'
                      '4. Merchants guarantee their information does not violate any third-party copyrights.\n'
                      '5. Merchants will contact customers only as necessary for processing transactions and will not send unsolicited advertisements. They must not advertise competitors when delivering products sold via Ngbuka.\n'
                      '6. Merchants must process orders and arrange delivery with reasonable care immediately upon receiving confirmation of sale. Delivery should be within 1 working day. Repeated stock-outs will result in removal from the platform.\n'
                      '7. If a merchant cannot fulfill an order, they must notify Ngbuka as soon as possible, and within 1 day of receiving the order.\n'
                      '8. Merchants agree to adhere to their product range and prices as described on their listings. They guarantee no ongoing criminal, bankruptcy, or tax issues relate to their products. They must keep their product range, stock count, prices, and terms up-to-date.\n'
                      '9. Merchants must provide Ngbuka with a copy of their valid Identity Card at the contract signing.\n'
                      '10. Merchants are allowed to have a wallet on the Ngbuka platform.',
                ),
                buildPolicySection(
                  header: '4. Commission',
                  body:
                      '1. Merchants agree to pay Ngbuka a fixed 10% commission on the gross revenue from sales and services made through the platform.\n'
                      '2. Ngbuka may introduce additional fees for selling goods through the platform, such as listing fees or marketing fees, with prior written notice to the merchant, who can opt out.\n'
                      '3. Ngbuka reserves the right to adjust the commission percentage with suitable notice to the merchant.',
                ),
                buildPolicySection(
                  header: '5. Customer Online Payment',
                  body:
                      '1. For electronic payments by customers, Ngbuka collects payments on behalf of the merchant and sends the money to the merchant\'s wallet on the platform according to the invoicing agreement.\n'
                      '2. Merchants must keep delivery receipts for at least 13 months and provide them on request. They must immediately notify Ngbuka of any delivery issues.\n'
                      '3. Merchants bear the risk of payment fraud. Ngbuka reserves the right to correct invoices to offset fraudulent payments.',
                ),
                buildPolicySection(
                  header: '6. Invoicing and Merchant Payment',
                  body:
                      '1. Ngbuka\'s invoices include claims on the merchant, commission, and other applicable fees.\n'
                      '2. If merchants receive payments directly, they must pay the agreed commission to Ngbuka within 5 days of receiving the statement.\n'
                      '3. Payments are made by bank transfer or cross cheque payable to ‘Ngbuka’.',
                ),
                buildPolicySection(
                  header: '7. Liability',
                  body:
                      '1.Merchants indemnify Ngbuka from all claims related to matters outside Ngbuka\'s control, including the quality of goods and services provided by the seller. Merchants further indemnify Ngbuka from third-party claims resulting from legal violations by the seller.\n'
                      '2. Ngbuka cannot guarantee a malfunction-free service but will exercise reasonable care and skill to resolve issues.\n'
                      '3. VAT liability rests with the merchant; Ngbuka is not responsible for any VAT issues.',
                ),
                buildPolicySection(
                  header: '8. Privacy',
                  body:
                      'Both parties must treat the content of this agreement and all related information confidentially and not use it outside the scope of this contract. This obligation lasts for 1 year after contract termination. Both parties must follow privacy laws and handle customer, supplier, and business partner data accordingly.',
                ),
                buildPolicySection(
                  header: '9. Licence',
                  body:
                      '1. Ngbuka has the right to maintain the merchant\'s listing and ranking on the platform. Ngbuka may publish customer ratings and reviews and reserves the right to delete them.\n'
                      '2. Ngbuka may scan, transcribe, and publish the merchant\'s listings, logos, and other materials. Merchants grant Ngbuka a royalty-free, perpetual license to use these materials for advertising, including in online marketing and SEO measures.',
                ),
                buildPolicySection(
                  header: '10. Terms and Termination',
                  body:
                      '1. This agreement is valid upon signing or order fulfillment by the merchant and remains valid indefinitely until terminated by either party with one month\'s notice. Revenues generated during the notice period are subject to the partnership agreement. Immediate termination is possible for important causes.\n'
                      '2. Immediate termination includes repeated negative ratings and reviews not obviously unjustified, and misleading information or withholding required information. Typos, mistakes, and transmission errors are excluded if not caused with intent or gross negligence.',
                ),
                buildPolicySection(
                  header: '11. General',
                  body:
                      'If a clause in this agreement is invalid, the parties will replace it with a valid one that closely reflects the intended meaning. The validity of the rest of the agreement remains unaffected.\n'
                      'Ngbuka reserves the right to modify its general terms and conditions, providing adequate notice to the merchant. The notice will include information on the right to object.\n'
                      'Changes are considered agreed upon if the merchant does not object in writing within 2 weeks.\n'
                      'Merchant terms and conditions are not part of this agreement unless Ngbuka expressly agrees in writing.',
                ),
                buildPolicySection(
                  header: 'Contact us',
                  body: 'If you have any questions, Please contact us at:\n'
                      'Email: info@ngbuka.com.ng\n'
                      'Phone: 07073042235\n'
                      'Address: Km 16 East/West Road Rumuosi, Port Harcourt, Rivers State',
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget buildPolicySection({required String header, required String body}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(
          text: header,
          fontSize: 14,
          textColor: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 5),
        customText(
          text: body,
          fontSize: 14,
          textColor: Colors.black,
        ),
      ],
    ),
  );
}
