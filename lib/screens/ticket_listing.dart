import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teneant_complaint_registration_app/screens/register_complaint.dart';
import '../commons/colors.dart';
import '../widgets/custom_paint_widget.dart';

class MyTickets extends StatefulWidget {
  const MyTickets({super.key});

  @override
  State<MyTickets> createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 208, 197, 197),
        appBar: AppBar(
      backgroundColor: Colors.red,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Navigate back to the previous screen
            },
          ),
          title: const Text(
            'My Tickets',
            style: TextStyle(color: AppColors.whiteColor),
          ),
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255),
            // Set the color of the drawer icon
          ),
          actions: [
            IconButton(
              onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterComplaint(),
                        ),
                      );
              },
              icon: Icon(Icons.add),
            )
          ],
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              TicketContainer(status: 'Pending',),
              TicketContainer(status: 'Processing',),
              TicketContainer(status: 'Completed',),
              TicketContainer(status: 'Processing',),
            ],
          ),
        ));
  }
}

class TicketContainer extends StatelessWidget {
  const TicketContainer({
    super.key, required this.status,
  });
  final String status;
  
  

  @override
  Widget build(BuildContext context) {

       final statusColors = {
      'Pending': Colors.red,
      'Completed': Colors.green,
      'Processing': Colors.blue,
    };
final color = statusColors[status] ?? Colors.black;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Shadow color
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: const Color(0xFFF006C67),
                    child: const Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          '#ticket1',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color(0xFFFFEBC6),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '',
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          Expanded(
                            child: Row(children: [
                              Expanded(
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Text(
                                            'Category:',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Plumbing',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          )
                                        ],
                                      ),
                                       Row(
                                        children: [
                                          const Text(
                                            'Status:',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              status,
                                              style:  TextStyle(
                                                  color: color,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            'Created At:',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '2024-08-28',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            'Updated At:',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '2024-08-28',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              //  backgroundColor: buttonBg,
                                              // shape: StadiumBorder(
                                              //   side: BorderSide(
                                              //       width: 1,
                                              //       color: buttonBorderColor),
                                              // )
                                              ),
                                          // icon: Icon(buttonIcon,
                                          //     color: buttonIconColor),
                                          label: const Text(
                                            'View ticket',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ]),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            CustomPaintWidget(
              painter: SideCutsDesign(arcColor: const Color(0xFFD2D6EF)),
              height: 200,
            ),
            CustomPaintWidget(
              painter: DottedInitialPath(
                dotColor: const Color.fromARGB(255, 172, 187, 13),
              ),
              height: 200,
            ),
            CustomPaintWidget(
              painter: DottedMiddlePath(
                dotColor: const Color.fromARGB(221, 3, 111, 23),
              ),
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}

class DottedMiddlePath extends CustomPainter {
  final Color dotColor;

  DottedMiddlePath({required this.dotColor});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3;
    double dashSpace = 4;
    double startY = 1;
    final paint = Paint()
      ..color = dotColor
      ..strokeWidth = 1;

    while (startY < size.height) {
      canvas.drawCircle(Offset(size.width / 5, startY), 2, paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DottedInitialPath extends CustomPainter {
  final Color dotColor;

  DottedInitialPath({required this.dotColor});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3;
    double dashSpace = 4;
    double startY = 1;
    final paint = Paint()
      ..color = dotColor
      ..strokeWidth = 1;

    while (startY < size.height) {
      canvas.drawCircle(Offset(0, startY), 2, paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SideCutsDesign extends CustomPainter {
  final Color arcColor;

  SideCutsDesign({required this.arcColor});

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    // canvas.drawArc(
    //   Rect.fromCircle(center: Offset(0, h / 2), radius: 18),
    //   0,
    //   10,
    //   false,
    //   Paint()
    //     ..style = PaintingStyle.fill
    //     ..color = arcColor,
    // );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(w, h / 2), radius: 18),
      0,
      10,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..color = arcColor,
    );
    // canvas.drawArc(
    //   Rect.fromCircle(center: Offset(w / 5, h), radius: 5),
    //   0,
    //   10,
    //   false,
    //   Paint()
    //     ..style = PaintingStyle.fill
    //     ..color = arcColor,
    // );
    // canvas.drawArc(
    //   Rect.fromCircle(center: Offset(w / 5, 0), radius: 5),
    //   0,
    //   10,
    //   false,
    //   Paint()
    //     ..style = PaintingStyle.fill
    //     ..color = arcColor,
    // );
    // canvas.drawArc(
    //   Rect.fromCircle(center: Offset(0, h), radius: 5),
    //   0,
    //   10,
    //   false,
    //   Paint()
    //     ..style = PaintingStyle.fill
    //     ..color = arcColor,
    // );
    // canvas.drawArc(
    //   Rect.fromCircle(center: const Offset(0, 0), radius: 5),
    //   0,
    //   10,
    //   false,
    //   Paint()
    //     ..style = PaintingStyle.fill
    //     ..color = arcColor,
    // );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
