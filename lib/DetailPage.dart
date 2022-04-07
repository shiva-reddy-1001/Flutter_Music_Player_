import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/Musics.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key key, this.musics, this.mMusic, this.index})
      : super(key: key);
  final List musics;
  final Musics mMusic;
  final int index;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  
  IconData btnIcon = Icons.play_arrow;
  var bgColor = const Color(0x00000000);
  var iconHoverColor = const Color(0xFF065BC3);

  Duration duration = new Duration();
  Duration position = new Duration();

  
  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  String currentSong = "";

  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
          btnIcon = Icons.pause;
        });
      }
    }
    
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00000000),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 500.0,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.mMusic.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [bgColor.withOpacity(0.4), bgColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 52.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'PLAYLIST',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6)),
                                  ),
                                  Text('Best Hits of the year',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(widget.mMusic.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0)),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            widget.mMusic.singer,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 18.0),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 42.0,
              ),
              Slider.adaptive(
                
                value: position.inSeconds.toDouble(),
                min: 0.0,
                max: duration.inSeconds.toDouble(),
                onChanged: (value) {
                  audioPlayer.seek(Duration(seconds: value.toInt())); 
                },
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.fast_rewind, color: Colors.white54),
                    iconSize: 42.0,
                    onPressed: () {
                      int index;
                      audioPlayer.stop();
                      if (widget.index == 0) {
                        index = widget.musics.length - 1;
                      } else {
                        index = widget.index - 1;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                musics: widget.musics,
                                mMusic: widget.musics[index],
                                index: index)),
                      );
                    },
                  ),
                  SizedBox(width: 32.0),
                  Container(
                    decoration: BoxDecoration(
                        color: iconHoverColor,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            playMusic(widget.mMusic.url);
                            if (isPlaying) {
                              audioPlayer.pause();
                              setState(() {
                                btnIcon = Icons.play_arrow;
                                isPlaying = false;
                              });
                            } else {
                              audioPlayer.resume();
                              setState(() {
                                btnIcon = Icons.pause;
                                isPlaying = true;
                              });
                            }
                          },
                          iconSize: 42.0,
                          icon: Icon(btnIcon),
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(width: 32.0),
                  IconButton(
                    icon: Icon(Icons.fast_forward, color: Colors.white54),
                    iconSize: 42.0,
                    onPressed: () {
                      int index;
                      index = (widget.index + 1) % widget.musics.length;
                      audioPlayer.stop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                musics: widget.musics,
                                mMusic: widget.musics[index],
                                index: index)),
                      );
                    },
                  ),
                ],
              ),
              Spacer(),
              SizedBox(height: 58.0),
            ],
          ),
        ),
      ),
    );
  }
}
