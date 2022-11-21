import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ecommerce/modules/favorites_screen/favorites_screen.dart';
import 'package:ecommerce/modules/search_screen/search_screen.dart';

import 'package:ecommerce/shared/Constans/constans.dart';
import 'package:ecommerce/shared/Styles/colors.dart';
import 'package:ecommerce/shared/Styles/theme/cubit/cubit.dart';
import 'package:ecommerce/layout/Bloc/cubit.dart';
import 'package:ecommerce/layout/Bloc/states.dart';
import 'package:ecommerce/shared/compoenets/widgets.dart';
import '../../modules/cart_screen/cart_screen.dart';

class HomeLayout extends StatelessWidget {
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      // not logo yet
                      //backgroundImage: AssetImage('assets/images/logo.png',),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('e-commerce ',
                        style: TextStyle(
                            fontFamily: 'Pacifico',
                            color: defultColor,
                            fontSize: 24))
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        NavigateTo(router: SearchScreen(), context: context);
                      },
                      icon: Icon(
                        Icons.search,
                        color: defultColor,
                        size: 30,
                      )),
                ]),
            body: cubit.Screen[cubit.CurrentIndex],
            //cartModel.data.cartItems.isEmpty
            floatingActionButton: true
                ? FloatingActionButton(
                    onPressed: () {
                      NavigateTo(router: CartScreen(), context: context);
                    },
                    child: Icon(Icons.shopping_cart),
                    backgroundColor: defultColor,
                  )
                : Badge(
                    badgeContent: Text("${3}",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    child: FloatingActionButton(
                      onPressed: () {
                        NavigateTo(router: CartScreen(), context: context);
                      },
                      child: Icon(Icons.shopping_cart),
                      backgroundColor: defultColor,
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBarwidget(
              context,
              bgcolor: ThemeAppCubit.get(context).IsDark
                  ? HexColor('333739')
                  : Colors.white,
            ),

            //
            // bottomNavigationBar: BottomNavigationBar(
            //   items: cubit.bottomNavigation,
            //   currentIndex: cubit.CurrentIndex,
            //   onTap: (index) {
            //     cubit.ChangeIndex(index);
            //   },
            // ),
          );
        });
  }
}

