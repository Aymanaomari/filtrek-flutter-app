import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/presentation/providers/managers/choose_time/choose_time_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/providers/managers/choose_time/choose_time_screen_state.dart';
import 'package:filtrek_app/presentation/widgets/choose_time/choose_time_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

class ChooseTimeAppointmentScreen extends ConsumerWidget {
  final String coachId;
  const ChooseTimeAppointmentScreen({Key? key, required this.coachId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final chooseTimeNotifier =
        ref.read(chooseTimeScreenManagerProvider(coachId).notifier);
    final chooseTimeState = ref.watch(chooseTimeScreenManagerProvider(coachId));

    ref.listen<ChooseTimeScreenState>(
      chooseTimeScreenManagerProvider(coachId),
      (previous, next) {
        final prevState = previous;
        final nextState = next;
        if (prevState?.appointmentRequest?.date !=
            nextState.appointmentRequest?.date) {
          chooseTimeNotifier.loadSlots(nextState.appointmentRequest!.date);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            ChooseTimeCalendar(
              coachId: coachId,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                decoration: BoxDecoration(
                  color: colors.secondary,
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.homeSubscribtionCardBg),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                ),
                child: chooseTimeState.isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: colors.primary))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            chooseTimeState.availableSlots.isEmpty
                                ? "No Available Slots"
                                : "Choose Time".capitalize(),
                            style: AppTypography.h1.copyWith(
                              color: colors.primary,
                            ),
                          ),
                          chooseTimeState.isLoading
                              ? SizedBox(
                                  height: 48,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: colors.primary),
                                  ),
                                )
                              : DropdownButtonHideUnderline(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: colors.outlineVariant,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(16),
                                      color: colors.surface,
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: chooseTimeState.appointmentRequest
                                                      ?.slot !=
                                                  null &&
                                              chooseTimeState.availableSlots
                                                  .contains(chooseTimeState
                                                      .appointmentRequest?.slot)
                                          ? chooseTimeState
                                              .appointmentRequest?.slot
                                          : null,
                                      hint: Text("Select a slot"),
                                      items: chooseTimeState.availableSlots
                                          .toSet() // Remove any duplicates
                                          .map<DropdownMenuItem<String>>(
                                              (slot) =>
                                                  DropdownMenuItem<String>(
                                                    value: slot,
                                                    child: Text(slot),
                                                  ))
                                          .toList(),
                                      onChanged: (value) {
                                        chooseTimeNotifier.selectSlot(value);
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      dropdownColor: colors.surface,
                                    ),
                                  ),
                                ),
                          SwipeButton.expand(
                            duration: Duration(microseconds: 750),
                            height: 56,
                            thumb: Icon(
                              Icons.arrow_forward,
                              weight: 32,
                              color: colors.surface,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            thumbPadding: EdgeInsets.all(6),
                            child: Text("Swipe to Book",
                                textAlign: TextAlign.start,
                                style: AppTypography.body1
                                    .copyWith(color: colors.outline)),
                            activeThumbColor: colors.primary,
                            activeTrackColor: colors.surface,
                            onSwipe: () async {
                              final success =
                                  await chooseTimeNotifier.makeAppointment();
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Appointment booked successfully!"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                // You might want to navigate back or to a confirmation screen here
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Failed to book appointment. Please try again."),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
