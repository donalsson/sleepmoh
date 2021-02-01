import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sleepmohapp/DataSample/ImagesModel.dart';

class gallery extends StatefulWidget {
  List<Imagem> img;
  gallery({Key key, this.img}) : super(key: key);
  @override
  _galleryState createState() => _galleryState();
}

class _galleryState extends State<gallery> {
  @override
  void initState() {
    super.initState();
      
     print(widget.img);
     print('widget.img');
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: PageView(
        controller: PageController(
          initialPage: 0,
        ),
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        children: widget.img.map<Widget>((data) => _buildBody(context, data)).toList(),
                            
         
                                       ),
                                     );
                                   }
                                  
                                 
               }
               
   Widget _buildBody(BuildContext context, Imagem data) {
    return Padding(
      
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(data.imgh_name),
                fit: BoxFit.cover),
          ),
                                            
    )
    );
  }