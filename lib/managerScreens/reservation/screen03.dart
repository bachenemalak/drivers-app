import 'package:flutter/material.dart';
import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScreenThree extends StatelessWidget {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final controller = Get.put(DateTimeController());
  ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('Select Date', style: AppTextStyles.subtitle),
        Obx(
          () => TextField(
            readOnly: true,
            controller: TextEditingController(text: controller.dateText),
            decoration: InputDecoration(
              hintText: 'Select Date',
              prefixIcon: Image.asset('images/oui_token-date.png'),
              suffixIcon: Icon(
                controller.showDatePicker.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color.fromRGBO(65, 66, 67, 1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            onTap: () {
              controller.showDatePicker.toggle();
              controller.showTimePicker.value = false;
            },
          ),
        ),

        Obx(
          () =>
              controller.showDatePicker.value
                  ? Container(
                    height: 250,

                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.07)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Color.fromARGB(120, 0, 0, 0),
                          onPrimary: Colors.white,
                        ),
                        datePickerTheme: const DatePickerThemeData(
                          todayBackgroundColor: WidgetStatePropertyAll(
                            Colors.black,
                          ),
                          todayForegroundColor: WidgetStatePropertyAll(
                            Colors.white,
                          ),
                          dayForegroundColor: WidgetStatePropertyAll(
                            Colors.black,
                          ),
                          yearForegroundColor: WidgetStatePropertyAll(
                            Colors.black,
                          ),
                        ),
                      ),
                      child: CalendarDatePicker(
                        initialDate:
                            controller.selectedDate.value ?? DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2090),
                        onDateChanged: (date) {
                          controller.selectedDate.value = date;
                          controller.showDatePicker.value = false;
                        },
                      ),
                    ),
                  )
                  : const SizedBox(),
        ),
        SizedBox(height: 16),
        Text('Select Time', style: AppTextStyles.subtitle),
        Obx(
          () => TextField(
            readOnly: true,
            controller: TextEditingController(text: controller.timeText),
            decoration: InputDecoration(
              hintText: 'Select Time',
              prefixIcon: Image.asset('images/carbon_time.png'),
              suffixIcon: Icon(
                controller.showTimePicker.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color.fromRGBO(65, 66, 67, 1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            onTap: () {
              controller.showTimePicker.toggle();
              controller.showDatePicker.value = false;
            },
          ),
        ),

        Obx(
          () =>
              controller.showTimePicker.value
                  ? Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      height: 120,
                      child: TimePickerSpinner(controller: controller),
                    ),
                  )
                  : const SizedBox(),
        ),
        SizedBox(height: 25),
        devider,
        theRow,
      ],
    );
  }
}

class TimePickerSpinner extends StatelessWidget {
  final DateTimeController controller;

  const TimePickerSpinner({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final hours = List.generate(12, (i) => i + 1);
    final minutes = List.generate(60, (i) => i);
    final amPm = ['AM', 'PM'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildList(hours, (h) => h.toString().padLeft(2, '0')),
        _buildList(minutes, (m) => m.toString().padLeft(2, '0')),
        _buildList(amPm, (p) => p),
      ],
    );
  }

  Widget _buildList(List items, String Function(dynamic) label) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          return ListTile(
            title: Center(child: Text(label(items[i]))),
            onTap: () {
              final now = DateTime.now();
              controller.selectedTime.value = DateTime(
                now.year,
                now.month,
                now.day,
                items is List<int> ? items[i] : now.hour,
                items is List<int> ? items[i] : now.minute,
              );
              controller.showTimePicker.value = false;
            },
          );
        },
      ),
    );
  }
}

class DateTimeController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedTime = Rx<DateTime?>(null);

  RxBool showDatePicker = false.obs;
  RxBool showTimePicker = false.obs;

  String get dateText =>
      selectedDate.value == null
          ? ''
          : DateFormat('dd.MM.yyyy').format(selectedDate.value!);

  String get timeText =>
      selectedTime.value == null
          ? ''
          : DateFormat('hh:mm a').format(selectedTime.value!);
}
