import 'package:appservicable/src/settings/persistence.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/parrillaHomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:appservicable/src/widgets/contacto_widget.dart';
import 'package:appservicable/src/widgets/home_widget.dart';
import 'package:appservicable/src/widgets/internet_widget.dart';
import 'package:appservicable/src/widgets/programacion_widget.dart';
import 'package:appservicable/src/widgets/solicitud_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

 
class DashboardPage extends StatefulWidget {
  
  @override
  DashboardPageState createState() => DashboardPageState();

}

class DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  TabController _controllerTab;
  final prefs= new PersistenceLocal();
  static var myTabbedPageKey = new GlobalKey<DashboardPageState>();
  @override
  void initState() {
    super.initState();
    final vm= Provider.of<ParrillaHomeViewModel>(context, listen: false);
    _controllerTab = new TabController(vsync: this, length: (prefs.isClient)?5:4, initialIndex: vm.index);
  
  }

 

  @override
  void dispose() {
    _controllerTab.dispose();
    super.dispose();
  }
  
   
   void functionTab(){
     myTabbedPageKey.currentState._controllerTab.animateTo(5);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: SizesCustom.width,
        height: SizesCustom.height,
        allowFontScaling: true);
    return Scaffold(
      
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: _tabsNavigation(),
      body:   _pagesTab(_controllerTab),
    );
  }

  Widget _tabsNavigation() {
    return Material(
      color: Color.fromRGBO(9, 88, 145, 1),
      child: TabBar(
        key: myTabbedPageKey,
        labelColor: Colors.white,
        indicatorColor: Colors.white,
        controller: _controllerTab,
        labelPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        labelStyle: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
        ),
        tabs: (prefs.isClient)?<Widget>[
          new Tab(
            icon: new Icon(Icons.home),
            text: "Cuenta",
          ),
          new Tab(
            //icon: new Icon(Icons.personal_video),
            icon: Image.asset(
              'assets/images/iconos/remoto.png',
              height: 30.0,
            ),
            text: "Programación",
          ),
          new Tab(
            //icon: new Icon(Icons.wifi),
            icon: Image.asset(
              'assets/images/iconos/enrutador.png',
              height: 30.0,
            ),
            text: "Internet",
          ),
          new Tab(
            //icon: new Icon(Icons.contact_mail),
            icon: Image.asset(
              'assets/images/iconos/tecnico.png',
              height: 30.0,
            ),
            text: "Solicitud",
          ),
          new Tab(
            //icon: new Icon(Icons.perm_phone_msg),
            icon: Image.asset(
              'assets/images/iconos/contacto.png',
              height: 30.0,
            ),
            text: "Contacto",
          ),
        ]:
        <Widget>[
          
          new Tab(
            //icon: new Icon(Icons.personal_video),
            icon: Image.asset(
              'assets/images/iconos/remoto.png',
              height: 30.0,
            ),
            text: "Programación",
          ),
          new Tab(
            //icon: new Icon(Icons.wifi),
            icon: Image.asset(
              'assets/images/iconos/enrutador.png',
              height: 30.0,
            ),
            text: "Internet",
          ),
          new Tab(
            //icon: new Icon(Icons.contact_mail),
            icon: Image.asset(
              'assets/images/iconos/tecnico.png',
              height: 30.0,
            ),
            text: "Solicitud",
          ),
          new Tab(
            //icon: new Icon(Icons.perm_phone_msg),
            icon: Image.asset(
              'assets/images/iconos/contacto.png',
              height: 30.0,
            ),
            text: "Contacto",
          ),
        ],
      ),
    );
  }

  Widget _pagesTab(TabController _controller) {
    return TabBarView(
      controller: _controller,
      children: (prefs.isClient)?<Widget>[
        HomeWidget(),
        ProgramacionWidget(),
        InternetWidget(),
        SolicitudWidget(),
        ContactoWidget(),
      ]:
      <Widget>[
        ProgramacionWidget(),
        InternetWidget(),
        SolicitudWidget(),
        ContactoWidget(),
      ],
    );
  }
}