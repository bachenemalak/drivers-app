import 'package:car_app/managerScreens/reservation/res_screens.dart';
import 'package:flutter/material.dart';
import 'package:car_app/managerScreens/reservation/materials.dart';
import 'package:get/get.dart';
import 'package:car_app/managerScreens/reservation/screen06.dart';

class ScreenFour extends StatelessWidget {
  const ScreenFour({super.key});

  @override
  Widget build(BuildContext context) {
    final VehicleDetailsController controller = Get.put(
      VehicleDetailsController(),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('Select Vehicle Class', style: AppTextStyles.subtitle),
        SizedBox(height: 9),

        Obx(
          () => Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color.fromRGBO(218, 218, 218, 1)),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(6, 8, 8, 8),
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: controller.textController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: 'Select Item',
                hintStyle: AppTextStyles.subtitle,
                suffixIcon: Icon(
                  controller.showvehicleClass.value
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent, width: 1),
                ),
              ),
              readOnly: true, // makes it non-editable
              onTap: () {
                controller.showvehicleClass.toggle();
              },
            ),
          ),
        ),
        Obx(
          () =>
              controller.showvehicleClass.value
                  ? Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 100,
                    child: ListView.builder(
                      itemCount: controller.vehicles.length,
                      itemBuilder: (_, index) {
                        final item = controller.vehicles[index];
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            controller.selectVehicle(item);
                          },
                        );
                      },
                    ),
                  )
                  : const SizedBox(),
        ),
        SizedBox(height: 20),
        Obx(
          () => NumberContainer(
            title: 'Vehicle Capacity',
            onTapDown: controller.subcapacity,
            onTapup: controller.addCapcity,
            number: controller.capacity.value.toString(),
          ),
        ),
        SizedBox(height: 36),
        Row(
          children: [
            SwitchButton(ison: controller.childSeat),
            SizedBox(width: 5),
            Text('Child Seat', style: AppTextStyles.subtitle),
          ],
        ),
        SizedBox(height: 18),
        Row(
          children: [
            SwitchButton(ison: controller.wheelchair),
            SizedBox(width: 5),
            Text('Wheelchair access', style: AppTextStyles.subtitle),
          ],
        ),
        SizedBox(height: 50),
        devider,
         Row(children: [Reviewbtn(), Spacer(), // At the bottom of TransfersAirport widget
// At the bottom of AsDirected widget
// At the bottom of ScreenThree
// At the bottom of ScreenFour
NextBtn(
  onPressedCallback: () {
    final tripController = Get.find<TripFormController>();
    final vehicleController = Get.find<VehicleDetailsController>();
    
    tripController.vehicleClass.value = vehicleController.selectedVehicle.value;
    tripController.capacity.value = vehicleController.capacity.value;
    tripController.childSeat.value = vehicleController.childSeat.value;
    tripController.wheelchair.value = vehicleController.wheelchair.value;
  },
)])
      ],
    );
  }
}

class VehicleDetailsController extends GetxController {
  RxBool childSeat = false.obs;
  RxBool wheelchair = false.obs;
  RxInt capacity = 0.obs;
  RxBool showvehicleClass = false.obs;
  var textController = TextEditingController();
  var selectedVehicle = ''.obs;
  final vehicles = ['sundan', 'chourouk', 'israa'];

  void addCapcity() {
    capacity.value++;
  }

  void subcapacity() {
    if (capacity.value == 0) {
      capacity.value;
    } else {
      capacity.value--;
    }
  }

  void selectVehicle(String vechicle) {
    textController.text = vechicle;
    selectedVehicle.value = vechicle;
    showvehicleClass.value = false;
  }
}
