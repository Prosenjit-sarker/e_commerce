import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/cart/presentation/widgets/total_price_and_checkout_section.dart';
import 'package:crafty_bay/features/shared/Presentation/widgets/inc_dec_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';
import '../../../shared/Presentation/providers/main_nav_provider.dart';
import '../../../shared/Presentation/widgets/categori_card.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _onTapBackButton();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _onTapBackButton,
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Carts'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return CartItem();
                },
              ),
            ),
            TotalPriceAndCheckoutSection(totalPrice: 120, onTapCheckout: () {}),
          ],
        ),
      ),
    );
  }

  void _onTapBackButton() {
    context.read<MainNavProvider>().backToHome();
  }
}

