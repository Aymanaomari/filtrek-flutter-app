import 'package:filtrek_app/presentation/providers/managers/client_plan/client_plan_screen_manager.dart';
import 'package:filtrek_app/presentation/widgets/client_plan/calendar_header.dart';
import 'package:filtrek_app/presentation/widgets/client_plan/custom_client_sfcalendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientPlanScreen extends ConsumerStatefulWidget {
  const ClientPlanScreen({super.key});

  @override
  ConsumerState<ClientPlanScreen> createState() => _ClientPlanScreenState();
}

class _ClientPlanScreenState extends ConsumerState<ClientPlanScreen> {
  @override
  Widget build(BuildContext context) {
    final clientPlanNotifier =
        ref.read(clientPlanScreenManagerProvider.notifier);
    final clientPlanState = ref.watch(clientPlanScreenManagerProvider);

    return RefreshIndicator(
        onRefresh: () async {
          await clientPlanNotifier.getDataSource();
        },
        child: SafeArea(
          child: Column(
            children: [
              CalendarHeader(),
              Expanded(
                child: CustomClientSfcalendar(),
              ),
            ],
          ),
        ));
  }
}
