import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lagbaja_cleaning/screens/home/dashboard.dart';

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const BodyTextSize = 16.0;
const SmallTextSize = 12.0;

const String FontNameDefault = 'Montserrat';

const AppBarTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w300,
  fontSize: MediumTextSize,
  color: Colors.white,
);

const SemiBoldTitleTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w500,
  fontSize: MediumTextSize,
  color: Colors.black,
);

const BoldTitleTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w700,
  fontStyle: FontStyle.normal,
  fontSize: LargeTextSize,
  color: Colors.black,
);

const BoldItalicTitleTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w700,
  fontStyle: FontStyle.italic,
  fontSize: LargeTextSize,
  color: Colors.black,
);

const BodyTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w300,
  fontSize: BodyTextSize,
  color: Colors.black,
);
const SmallTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w300,
  fontSize: SmallTextSize,
  color: Colors.white,
);
Widget ComingSoonDialog = Container(
  height: 300,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
  ),
  child: Center(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
      children: [
        Image(
          height: 200,
          image: AssetImage("assets/images/coming_soon.png")
        ),
        Center(child: Text('Coming Soon!', style: BoldTitleTextStyle.copyWith(color: Colors.blue),))
      ],
    ),
    ),
  ),
);

ButtonStyle outlinedButtonStyle(BuildContext context) {
  return OutlinedButton.styleFrom(
    primary: Colors.blue,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ).copyWith(
    side: MaterialStateProperty.resolveWith<BorderSide>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          );
        return null; // Defer to the widget's default.
      },
    ),
  );
}

InputDecoration inputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[100], width: 0.5)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[100], width: 0.5)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 0.5)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 0.5)));
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          size: 50.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class NumericStepButton extends StatefulWidget {
  final int minValue;
  final int maxValue;

  final ValueChanged<int> onChanged;

  NumericStepButton(
      {Key key, this.minValue = 0, this.maxValue = 10, this.onChanged})
      : super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  int counter = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Theme.of(context).accentColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
            iconSize: 32.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                if (counter > widget.minValue) {
                  counter--;
                }
                widget.onChanged(counter);
              });
            },
          ),
          Text(
            '$counter',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).accentColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
            iconSize: 32.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                if (counter < widget.maxValue) {
                  counter++;
                }
                widget.onChanged(counter);
              });
            },
          ),
        ],
      ),
    );
  }
}

List<String> weekdays = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
];

Widget successImage() {
  return Container(
    child: Column(
      children: [
        Image(
          height: 250,
          image: AssetImage('assets/images/payment_success.png'),
        ),
        Text(
          'We are on our way!',
          style: BoldTitleTextStyle.copyWith(color: Colors.blue),
        )
      ],
    ),
  );
}
