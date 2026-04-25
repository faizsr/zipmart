import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:zipmart/src/config/router/app_routes.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:zipmart/src/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:zipmart/src/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:zipmart/src/features/dashboard/presentation/widgets/dashboard_banner.dart';
import 'package:zipmart/src/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:zipmart/src/features/dashboard/presentation/widgets/dashboard_product_card.dart';
import 'package:zipmart/src/features/dashboard/presentation/widgets/dashboard_product_card_skelton.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, this.email});

  final String? email;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ScrollController _scrollController = ScrollController();

  late DashboardBloc dashboardBloc;

  @override
  void initState() {
    dashboardBloc = context.read<DashboardBloc>();
    // fetch products and categories
    dashboardBloc.add(FetchProductsEvent());
    dashboardBloc.add(FetchCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthStatus && !current.isLoggedIn,
      listener: (context, state) {
        context.go(AppRoutes.login);
      },
      child: Scaffold(
        extendBody: true,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            DashboardHeader(),

            DashboardBanner(),

            _buildProductTitle(),
            _buildProductGridView(),

            SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
        bottomNavigationBar: _buildCartButton(context),
      ),
    );
  }

  SliverToBoxAdapter _buildProductTitle() {
    return SliverToBoxAdapter(
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoaded || state is DashboardLoading) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
              child: Text('Products', style: TextStyle(fontSize: 20)),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  SliverToBoxAdapter _buildProductGridView() {
    return SliverToBoxAdapter(
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return Wrap(
              runSpacing: 16,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: List.generate(10, (index) {
                return DashboardProductCardSkelton();
              }),
            );
          }
          if (state is DashboardLoaded) {
            return Wrap(
              runSpacing: 16,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: List.generate(state.products.length, (index) {
                return DashboardProductCard(product: state.products[index]);
              }),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildCartButton(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final hasItems = state is CartLoadedState && state.cartItems.isNotEmpty;

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          reverseDuration: Duration(milliseconds: 300),
          switchInCurve: Curves.elasticOut,
          switchOutCurve: Curves.easeInBack,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: hasItems
              ? GestureDetector(
                  key: ValueKey('cart_button_visible'),
                  onTap: () => context.push(AppRoutes.cart),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 24),
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(height: 36, width: 1, color: AppColors.white),
                        hSpace8,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Cart',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: AppColors.white),
                            ),
                            Text(
                              '${state.cartItems.length} item',
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(color: AppColors.lightGrey),
                            ),
                          ],
                        ),
                        Spacer(),
                        Iconify(Ep.right, color: AppColors.white),
                      ],
                    ),
                  ),
                )
              : SizedBox(key: ValueKey('cart_button_hidden')),
        );
      },
    );
  }
}
