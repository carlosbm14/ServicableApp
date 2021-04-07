import 'package:appservicable/src/models/carruselModel.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/initialViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> promociones;
  final heightCard;

  CardSwiper({@required this.promociones, this.heightCard});

  @override
  Widget build(BuildContext context) {
    return Consumer<PromosViewModel>(builder: (context, model, _) {
      List<Carrusel> carrusel = model.imagenesCarrusel;
      List<Carrusel> carru = carrusel;
       carru.sort((a, b) => a.id.compareTo(b.id));
      return 
      (carrusel.length==0)?
      
        Center(
          child: Container(
            height: heightCard * 0.50,
            child: Center(
              child: Container(
                height: w(100),
                width: w(100),
                child: CircularProgressIndicator()),
            )),
        )
          
      :
      Container(
        height: heightCard * 0.50, //_screenSize.width,
        width: double.infinity, //_screenSize.height * 0.5,
        child: Swiper(
          onTap: (value) {
            
            //urlWhatsapp();
          },
          index: carru.length,
          itemBuilder: (BuildContext context, int index) {
            return Hero(
              tag: index,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: InkWell(
                    onTap: (){
                         if(carru[index].nombre=='conoce_mas_productos'){
                final initial= Provider.of<InitialViewModel>(context, listen: false);
                initial.goConoceMasProductosPage(context);
            }
            else if(carru[index].nombre=='quiero_comprar'){
                Navigator.pushNamed(context, 'formularioQuieroComprar');
            }
                    },
                                      child: Container(
                        constraints: BoxConstraints.expand(),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/backgrounds/login.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: carru[index].urlImage,
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
                            })),
                  )
                  ),
            );
          },
          itemCount: carru.length,
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      );
    });
  }
}
