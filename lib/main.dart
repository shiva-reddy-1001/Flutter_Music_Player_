import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/components/ListView.dart';
import 'package:music_player/model/Musics.dart';
import 'package:flutter_svg/svg.dart';

import 'DetailPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicPlayer(),
    );
  }
}

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {

  List musics;

  @override
  void initState() {
    musics = getList();
    super.initState();
  }

  List getList() {
    return [
      Musics(
          title: "Naacho Naacho",
          singer: "M. M. Keeravani",
          url: "https://pagalworld4u.in/download/get.php?id=Naacho%20Naacho%20Song%20Vishal%20Mishra,%20Rahul%20Sipligunj.mp3",
          image: "https://www.prokerala.com/images/1200/new-poster-of-the-film-rrr-featuring-ram-charan-and-jr-ntr.jpg"),
    Musics(
        title: "Gerua",
        singer: "Arijit Singh",
        url: "https://pagalworld4u.in/download/get.php?id=Gerua%20Song%20Dilwale.mp3&yt=AEIVhBS6baE",
        image:
            "https://th.bing.com/th/id/OIP.iDVjR6u7NDVbGHizlWgPgAHaHz?pid=ImgDet&rs=1",
      ),
      Musics(
        title: "Sholay",
        singer: "M. M. Keeravani",
        url:"https://pagalworld4u.in/download/get.php?id=Sholay%20Song%20RRR.mp3&yt=r1Q5c61vhag",
        image:
            "https://www.prokerala.com/images/1200/new-poster-of-the-film-rrr-featuring-ram-charan-and-jr-ntr.jpg"
      ),
      Musics(
          title: "Srivalli",
          singer: "Devi Sri Prasad",
          url: "https://pagalworld4u.in/download/get.php?id=Srivalli%20Hindi%20Song%20Pushpa.mp3&yt=v2IGNN7CA4M",
          image:
              "https://th.bing.com/th/id/OIP.VefTF1ckr_Xnhw4WClrHHAHaNK?pid=ImgDet&rs=1"),
      Musics(
          title: "Soch Liya",
          singer: "Mithoon, Arijit Singh",
          url: "https://pagalworld4u.in/download/get.php?id=Soch%20Liya%20Song%20Mithoon,%20Arijit%20Singh.mp3",
          image:
              "https://th.bing.com/th/id/OIP.QAO6CpyFxG4m8sMrfi5WtgHaJQ?pid=ImgDet&rs=1"),
      Musics(
          title: "Eyy Bidda Ye Mera Adda",
          singer: "Devi Sri Prasad",
          url: "https://pagalworld4u.in/download/get.php?id=Eyy%20Bidda%20Ye%20Mera%20Adda%20Song%20Nakash%20Aziz.mp3",
          image:
              "https://th.bing.com/th/id/OIP.VefTF1ckr_Xnhw4WClrHHAHaNK?pid=ImgDet&rs=1"),
      Musics(
          title: "Chaand Baaliyan",
          singer: "Aditya",
          url: "https://pagalworld4u.in/download/get.php?id=Chaand%20Baaliyan%20Song%20Aditya%20A.mp3&yt=7c3-Gei5j4w",
          image:
              "https://pagalworld4u.in/wp-content/uploads/2022/03/7c3-Gei5j4w_maxres.jpg"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0x00000000),
        appBar: AppBar(
          backgroundColor: const Color(0x00000000),
          title: Text(
            "Music Player",
            style: TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                fontSize: 20.0),
          ),
        ),
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color(0x00000000),
          ),
          Column(children: [
            Expanded(
              child: ListView.builder(
                  itemCount: getList().length,
                  itemBuilder: (context, index) => customListView(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(musics: musics,mMusic : musics[index],index: index)),
                          );
                        },
                        title: musics[index].title,
                        singer: musics[index].singer,
                        image: musics[index].image,
                      )),
            ),
          ]),
        ]));
  }
}
