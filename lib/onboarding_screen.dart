import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/auth/loginPage.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _title() {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 's',
            style: GoogleFonts.portLligatSans(
              textStyle: Theme.of(context).textTheme.display1,
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10),
            ),
            children: [
              TextSpan(
                text: 'ge',
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
              TextSpan(
                text: 'ms',
                style: TextStyle(color: Color(0xffe46b10), fontSize: 40),
              ),
            ]),
      );
    }
    return Scaffold(
      body:  SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(

                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x000), Color(0xffe46b10)])),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
        
                  Container(
                     height: 500,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(child: _title()),
                              SizedBox(height: 20,),
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/splash_1.png',
                                  ),
                                  height: 250.0,
                                  width: 250.0,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Choose from wide\n       range of products',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Spectral',
                                  fontSize: 26.0,
                                  height: 1.5,
                                ),
                              ),


                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(child: _title()),
                              SizedBox(height: 20,),

                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/splash_2.png',
                                  ),
                                  height: 250.0,
                                  width: 250.0,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Get doorstep delivery\n       service!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Spectral',
                                  fontSize: 26.0,
                                  height: 1.5,
                                ),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(child: _title()),
                              SizedBox(height: 20,),

                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/splash_3.png',
                                  ),
                                  height: 250.0,
                                  width: 250.0,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Item recommendation\n       based on trends ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Spectral',
                                  fontSize: 26.0,
                                  height: 1.5,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  _currentPage != _numPages - 1
                      ? Expanded(

                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontFamily: "Spectral"
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  )
                      : Container(
                    padding: EdgeInsets.only(right: 10),

                    margin: EdgeInsets.only(top:35,),
                    alignment: Alignment.bottomRight,
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage() ));
                      },
                      child: Text(
                          'Continue',
                        style: TextStyle(
                          color: Colors.white,
                             fontSize: 22.0,
                          fontFamily: "Spectral"
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );


  }
}