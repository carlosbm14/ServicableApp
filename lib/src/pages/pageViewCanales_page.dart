import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/models/programacionModel.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/programacionViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter/cupertino.dart';

class PageViewCanales extends StatefulWidget {
  PageViewCanales({Key key}) : super(key: key);

  @override
  _PageViewCanalesState createState() => _PageViewCanalesState();
}

class _PageViewCanalesState extends State<PageViewCanales> {
  @override
  Widget build(BuildContext context) {

return Consumer<PromosViewModel>(builder: (context, model, _) {
      var promos= model.imagenesBackgrounds;
         Background foto;
         if(promos.length>0){
            foto =  promos.where((i) => i.nombre=='formulario_aumento_de_megas').first;
         }
         else{
           Provider.of<PromosViewModel>(context, listen:false).obtenerBackgrounds();
            foto=  null;
         }
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        floatingActionButton: _backButton(),
        body: Stack(
          children: [
            Container(
            constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/login.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: 
          (foto==null)?Offstage():
          CachedNetworkImage(
            fit: BoxFit.fill,
        imageUrl: (foto==null)?'':foto.urlImage,
        progressIndicatorBuilder: (context, url, downloadProgress) => 
                Center(
                  child: Container(
                    width: w(100),
                    height: w(100),
                    child: CircularProgressIndicator(value: downloadProgress.progress,)),
                ),
        errorWidget: (context, url, error) {
          
          return Container(
            
          );
        }
     ),),

          
                _pageSwiper()
          ],
        ));
});
  }

  Widget _pageSwiper() {
    final List<Programacion> canales =
        Provider.of<ProgramacionViewModel>(context, listen: false)
            .categoriaProgramacionSelected;

    return 
    (canales.length==1)? Container(
      width: double.infinity,
      height: double.infinity,
      child: _widgetCanal(canales[0])):
    Swiper(
      itemBuilder: (BuildContext context, int index) {
        return _widgetCanal(canales[index]);
      },
      indicatorLayout: PageIndicatorLayout.COLOR,
      autoplay: false,
      itemCount: canales.length,
      pagination: new SwiperPagination(),
      control: (canales.length>1)?new SwiperControl():null,
    );
  }

  Widget _widgetCanal(Programacion canal) {
    return CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: canal.url,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
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
                  style: TextStyle(color: Colors.white, fontSize: f(25)),
                )
              ],
            ),
          );
        });
  }

  Widget _backButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(10)),
      height: w(40),
      width: w(120),
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white)),
        shadowColor: Color.fromRGBO(206, 207, 207, 1),
        color: Colors.transparent,
        elevation: 7.0,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Text(
              'VOLVER',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: f(18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
