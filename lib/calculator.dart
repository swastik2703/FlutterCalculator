import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcButton(String txtbtn, Color btncolor, Color txtColor){
    return Container(
      child: ElevatedButton(
        onPressed: (){
          calculation(txtbtn);
        },

        child: Text(
          txtbtn,
          style: TextStyle(
            color: txtColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(20),
          primary: btncolor


        ),

      ),
      );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Calculator App",style: TextStyle(color: Colors.white),),backgroundColor: Colors.black,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Padding(padding: EdgeInsets.all(20),
                child: Text(text,textAlign: TextAlign.left,style: TextStyle(color: Colors.white,fontSize: 50),
                ),
                ),
                  ],
            ),

            //add button function
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("AC", Colors.blueGrey, Colors.black),
                calcButton("C", Colors.blueGrey, Colors.black),
                calcButton("%", Colors.blueGrey, Colors.black),
                calcButton("/", Colors.blueGrey, Colors.black)
              ],
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("7", Colors.white, Colors.black),
                calcButton("8", Colors.white, Colors.black),
                calcButton("9", Colors.white, Colors.black),
                calcButton("*", Colors.blueGrey, Colors.black)
              ],
            ),

            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("4", Colors.white, Colors.black),
                calcButton("5", Colors.white, Colors.black),
                calcButton("6", Colors.white, Colors.black),
                calcButton("-", Colors.blueGrey, Colors.black)
              ],
            ),

            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("1", Colors.white, Colors.black),
                calcButton("2", Colors.white, Colors.black),
                calcButton("3", Colors.white, Colors.black),
                calcButton("+", Colors.blueGrey, Colors.black)
              ],
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("00", Colors.white, Colors.black),
                calcButton("0", Colors.white, Colors.black),
                calcButton(".", Colors.white, Colors.black),
                calcButton("=", Colors.orange, Colors.white)
              ],
            ),
            SizedBox(height: 15,),
          ],
        ),

      ),
    );
  }

  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == '*') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }
      else if( preOpr == '%') {
        finalResult = mod();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == '*' || btnText == '/' || btnText == '=' || btnText == '%') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == '*') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      else if( opr == '%'){
        finalResult = mod();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mod() {
    result = (numOne % numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}
