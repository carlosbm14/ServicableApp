import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/checkConnection.dart';
import 'package:appservicable/src/viewmodels/programacionViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/functionsCommoms.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Background foto;

  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final vm=Provider.of<PromosViewModel>(context, listen: false);
    final progravm= Provider.of<ProgramacionViewModel>(context, listen: false);
     vm.obtenerBackgrounds();
     vm.obtenerpromos();
     vm.obtenerCarruselImages();
     vm.obtenerDistritos();
     vm.obtenerServiciosSolicitudServicios();
     vm.obtenerPlanesAumentodemegas();
     vm.obtenerCategoriaProductos();//principal
     vm.obtenerTiposProductos();//tipos
     vm.planesProductos();//descripcion
     progravm.obtenerprogramacion();
   //  vm.obtenerDepartamentos();
    // vm.obtenerProductosSolicitudServicios();
    // vm.obtenerProductosAumentodeMegas();

    ScreenUtil.init(context,
        width: SizesCustom.width,
        height: SizesCustom.height,
        allowFontScaling: true);
    getSizeDevice(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Consumer<PromosViewModel>(builder: (context, model, _) {
            final List<Background> promos = model.imagenesBackgrounds;
            
            if (promos.length > 0) {
              foto = promos.where((i) => i.nombre == 'inicio').first;
              
            }

            return Container(
                constraints: BoxConstraints.expand(),
                
                child: (foto == null)?
                Container()//Image.asset("assets/images/backgrounds/login.jpg")
                :
                CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: foto.urlImage,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                              child: Container(
                                  width: w(100),
                                  height: w(100),
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                  )),
                            ),
                    errorWidget: (context, url, error) {
                      return Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.portable_wifi_off,
                                size: w(120), color: Colors.white),
                            Text(
                              'No posee conexión a Internet...',
                              style: TextStyle(
                                  color: Colors.white, fontSize: f(25)),
                            )
                          ],
                        ),
                      );
                    }));
          }),
        ],
      ),
      floatingActionButton: _buttonInit(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buttonInit(BuildContext context) {
    return Container(
      height: 50.0,
      width: 200.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        shadowColor: Colors.blueAccent,
        color: Colors.white,
        elevation: 2.0,
        child: InkWell(
          onTap: () async{
           _alertLoading(context);
           final isOnline = await CheckConecction().isOnline(context);  

     if(isOnline){
       
          Navigator.of(context).pushNamedAndRemoveUntil('initial', (Route<dynamic> route) => false);
     }
     else{
       
       Navigator.pop(context);
       alertTryAgain(context);
     }
          },
          child: Center(
            child: Text(
              'INGRESAR',
              style: TextStyle(
                color: Color.fromRGBO(9, 88, 145, 1),
                fontWeight: FontWeight.bold,
                fontSize: f(26.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _alertLoading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text('Servicable', style: TextStyle(fontSize: f(20))),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: w(10)),
                Text(
                  'Verificando conexión...',
                  style: TextStyle(fontSize: f(20)),
                ),
                //FlutterLogo(size:100.0),
              ],
            ),
            actions: <Widget>[
            ],
          );
        });
  }

  
}
