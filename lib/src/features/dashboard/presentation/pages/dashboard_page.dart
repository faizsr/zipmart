import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zipmart/src/config/router/app_routes.dart';
import 'package:zipmart/src/core/constants/app_assets.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/utils/responsive_helper.dart';
import 'package:zipmart/src/core/widgets/k_filled_button.dart';
import 'package:zipmart/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:zipmart/src/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:zipmart/src/features/dashboard/presentation/widgets/dashboard_banner.dart';
import 'package:zipmart/src/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:zipmart/src/features/dashboard/presentation/widgets/dashboard_product_card.dart';
import 'package:zipmart/src/features/dashboard/presentation/widgets/dashboard_product_card_skelton.dart';
import 'package:zipmart/src/features/dashboard/presentation/widgets/floating_cart_banner.dart';

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
    double w = ResponsiveHelper.getWidth(context);

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthStatus && !current.isLoggedIn,
      listener: (context, state) {
        context.go(AppRoutes.login);
      },
      child: Scaffold(
        extendBody: true,
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                DashboardHeader(),

                if (state is DashboardFailed) ...[
                  SliverToBoxAdapter(child: SizedBox(height: 120)),
                  _buildErrorPlaceholder(w, context),
                ] else ...[
                  DashboardBanner(),

                  _buildProductTitle(),
                  _buildProductGridView(),

                  SliverToBoxAdapter(child: SizedBox(height: 120)),
                ],
              ],
            );
          },
        ),
        bottomNavigationBar: FloatingCartBanner(),
      ),
    );
  }

  SliverToBoxAdapter _buildErrorPlaceholder(double w, BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: w / 2,
              child: Image(image: AssetImage(AppAssets.error)),
            ),
            Text(
              'Something Went Wrong',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            vSpace4,
            Text(
              'Make sure internet is turned on and try again',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
            ),
            vSpace8,
            SizedBox(
              width: w * 0.2,
              child: KFilledButton(
                text: 'Retry',
                bgColor: AppColors.blue,
                padding: EdgeInsets.all(8),
                onPressed: () => context.pop(),
              ),
            ),
          ],
        ),
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
}
