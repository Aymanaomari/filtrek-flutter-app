import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = '/';
  static const String routePath = '/';

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _centerController;
  late AnimationController _leftTallController;
  late AnimationController _rightTallController;
  late AnimationController _leftMediumController;
  late AnimationController _rightMediumController;
  late AnimationController _leftSmallController;
  late AnimationController _rightSmallController;

  // Position animation controllers
  late AnimationController _leftTallPositionController;
  late AnimationController _rightTallPositionController;
  late AnimationController _leftMediumPositionController;
  late AnimationController _rightMediumPositionController;
  late AnimationController _leftSmallPositionController;
  late AnimationController _rightSmallPositionController;

  // Scale animation controller
  late AnimationController _scaleController;

  // Stack position animation controller
  late AnimationController _stackPositionController;

  // Text opacity animation controller
  late AnimationController _textController;

  late Animation<double> centerOpacity;
  late Animation<double> leftTallOpacity;
  late Animation<double> rightTallOpacity;
  late Animation<double> leftMediumOpacity;
  late Animation<double> rightMediumOpacity;
  late Animation<double> leftSmallOpacity;
  late Animation<double> rightSmallOpacity;

  // Position animations
  late Animation<Offset> leftTallPosition;
  late Animation<Offset> rightTallPosition;
  late Animation<Offset> leftMediumPosition;
  late Animation<Offset> rightMediumPosition;
  late Animation<Offset> leftSmallPosition;
  late Animation<Offset> rightSmallPosition;

  // Scale animation
  late Animation<double> scaleAnimation;

  // Stack position animation
  late Animation<Offset> stackPositionAnimation;

  // Text opacity animation
  late Animation<double> textOpacity;

  @override
  void initState() {
    super.initState();

    // Initialize opacity animation controllers
    _centerController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _leftTallController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _rightTallController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _leftMediumController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _rightMediumController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _leftSmallController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _rightSmallController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    // Initialize position animation controllers
    _leftTallPositionController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _rightTallPositionController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _leftMediumPositionController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _rightMediumPositionController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _leftSmallPositionController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _rightSmallPositionController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);

    // Initialize scale animation controller
    _scaleController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    // Initialize stack position animation controller
    _stackPositionController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    // Initialize text opacity animation controller
    _textController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);

    // Initialize opacity animations
    centerOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(_centerController);
    leftTallOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(_leftTallController);
    rightTallOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(_rightTallController);
    leftMediumOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(_leftMediumController);
    rightMediumOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(_rightMediumController);
    leftSmallOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(_leftSmallController);
    rightSmallOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(_rightSmallController);

    // Initialize position animations
    leftTallPosition =
        Tween<Offset>(begin: const Offset(-2.0, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _leftTallPositionController, curve: Curves.easeOut));
    rightTallPosition =
        Tween<Offset>(begin: const Offset(2.0, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _rightTallPositionController, curve: Curves.easeOut));
    leftMediumPosition =
        Tween<Offset>(begin: const Offset(-3.0, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _leftMediumPositionController, curve: Curves.easeOut));
    rightMediumPosition =
        Tween<Offset>(begin: const Offset(3.0, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _rightMediumPositionController, curve: Curves.easeOut));
    leftSmallPosition =
        Tween<Offset>(begin: const Offset(-4.0, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _leftSmallPositionController, curve: Curves.easeOut));
    rightSmallPosition =
        Tween<Offset>(begin: const Offset(4.0, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _rightSmallPositionController, curve: Curves.easeOut));

    // Initialize scale animation
    scaleAnimation = Tween<double>(begin: 1.0, end: 0.4).animate(
        CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut));

    // Initialize stack position animation
    stackPositionAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -0.1)).animate(
            CurvedAnimation(
                parent: _stackPositionController, curve: Curves.easeInOut));

    // Initialize text opacity animation
    textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    // Start animations sequentially
    _startAnimations();
  }

  void _startAnimations() async {
    await _centerController.forward();
    await Future.delayed(const Duration(milliseconds: 400));

    _leftTallController.forward();
    _rightTallController.forward();
    _leftTallPositionController.forward();
    _rightTallPositionController.forward();
    await Future.delayed(const Duration(milliseconds: 800));

    _leftMediumController.forward();
    _rightMediumController.forward();
    _leftMediumPositionController.forward();
    _rightMediumPositionController.forward();
    await Future.delayed(const Duration(milliseconds: 1200));

    _leftSmallController.forward();
    _rightSmallController.forward();
    _leftSmallPositionController.forward();
    _rightSmallPositionController.forward();

    // Wait for small elements to finish, then start scale animation
    await Future.delayed(const Duration(milliseconds: 800));
    await _scaleController.forward();

    // After scaling finishes, move stack up and show text
    _stackPositionController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _textController.forward();

    await Future.delayed(const Duration(seconds: 2));

    // Check user state and redirect accordingly
    _checkUserAndNavigate();
  }

  void _checkUserAndNavigate() async {
    try {
      final userNotifier = ref.read(userStateProvider.notifier);
      await userNotifier.loadCurrentUser();

      final userState = ref.watch(userStateProvider);

      if (userState.currentUser != null) {
        // User is logged in, redirect to welcome screen
        if (mounted) {
          // context.replaceNamed(RouteNames.welcome);
        }
      } else {
        // No user found, redirect to onboarding
        if (mounted) {
          context.replaceNamed(OnBoardingScreen.routeName);
        }
      }
    } catch (e) {
      // On error, redirect to onboarding
      if (mounted) {
        context.replaceNamed(OnBoardingScreen.routeName);
      }
    }
  }

  @override
  void dispose() {
    _centerController.dispose();
    _leftTallController.dispose();
    _rightTallController.dispose();
    _leftMediumController.dispose();
    _rightMediumController.dispose();
    _leftSmallController.dispose();
    _rightSmallController.dispose();

    _leftTallPositionController.dispose();
    _rightTallPositionController.dispose();
    _leftMediumPositionController.dispose();
    _rightMediumPositionController.dispose();
    _leftSmallPositionController.dispose();
    _rightSmallPositionController.dispose();
    _scaleController.dispose();
    _stackPositionController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final baseStackHeight = 220.0; // The original height of the stack
    final stackWidth = 240.0; // Fixed width for the stack

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: scaleAnimation,
          builder: (context, child) {
            final scaledHeight = baseStackHeight * scaleAnimation.value;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: scaledHeight,
                  child: Center(
                    child: SizedBox(
                      width: stackWidth,
                      height: scaledHeight,
                      child: SlideTransition(
                        position: stackPositionAnimation,
                        child: ScaleTransition(
                          scale: scaleAnimation,
                          child: Stack(
                            children: [
                              FadeTransition(
                                opacity: centerOpacity,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 20,
                                    width: 81,
                                    decoration: BoxDecoration(
                                        color: colors.primary,
                                        borderRadius:
                                            BorderRadius.circular(99)),
                                  ),
                                ),
                              ),
                              //1
                              Positioned(
                                top: scaledHeight / 2 - 45,
                                left: stackWidth / 2 - 70.0,
                                child: SlideTransition(
                                  position: leftTallPosition,
                                  child: FadeTransition(
                                    opacity: leftTallOpacity,
                                    child: Container(
                                      height: 90,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: colors.primary,
                                          borderRadius:
                                              BorderRadius.circular(80)),
                                    ),
                                  ),
                                ),
                              ),
                              //2
                              Positioned(
                                top: scaledHeight / 2 - 45,
                                left: stackWidth / 2 + 50.0,
                                child: SlideTransition(
                                  position: rightTallPosition,
                                  child: FadeTransition(
                                    opacity: rightTallOpacity,
                                    child: Container(
                                      height: 90,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: colors.primary,
                                          borderRadius:
                                              BorderRadius.circular(80)),
                                    ),
                                  ),
                                ),
                              ),
                              //
                              Positioned(
                                top: scaledHeight / 2 - 35,
                                left: stackWidth / 2 - 95.0,
                                child: SlideTransition(
                                  position: leftMediumPosition,
                                  child: FadeTransition(
                                    opacity: leftMediumOpacity,
                                    child: Container(
                                      height: 65,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: colors.primary,
                                          borderRadius:
                                              BorderRadius.circular(80)),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: scaledHeight / 2 - 35,
                                left: stackWidth / 2 + 75.0,
                                child: SlideTransition(
                                  position: rightMediumPosition,
                                  child: FadeTransition(
                                    opacity: rightMediumOpacity,
                                    child: Container(
                                      height: 65,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: colors.primary,
                                          borderRadius:
                                              BorderRadius.circular(80)),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: scaledHeight / 2 - 10,
                                left: stackWidth / 2 - 110.0,
                                child: SlideTransition(
                                  position: leftSmallPosition,
                                  child: FadeTransition(
                                    opacity: leftSmallOpacity,
                                    child: ClipRect(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: 0.5,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: colors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(80)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: scaledHeight / 2 - 10,
                                left: stackWidth / 2 + 100.0,
                                child: SlideTransition(
                                  position: rightSmallPosition,
                                  child: FadeTransition(
                                    opacity: rightSmallOpacity,
                                    child: ClipRect(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        widthFactor: 0.5,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: colors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(80)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: textOpacity,
                  child: Text(
                    'Welcome to Fitlek !',
                    style: AppTypography.h1.copyWith(color: colors.onSecondary),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
