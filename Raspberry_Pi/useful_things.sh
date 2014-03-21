#!/bin/bash


while [ 1 ] ; do
    ./raspi_listen.sh $1

    response=`cat test.txt | grep transcript | jq '.result[0].alternative[0].transcript'`

    regex='.*(t|T)ime.*'
    if [[ $response =~ $regex ]] ; then
      ./say.sh "the time is `date +%r`"
      sleep 10
      mplayer ~/python_games/beep2.ogg > /dev/null 2>&1 &
    fi

    regex='.*(d|D)ay.*'
    if [[ $response =~ $regex ]] ; then
      ./say.sh "today is `date +%A`"
      sleep 10
      mplayer --really-quiet ~/python_games/beep1.ogg > /dev/null 2>&1 &
    fi

    regex='.*(c|C)ool.*'
    if [[ $response =~ $regex ]] ; then
      ./say.sh "shiki no uta"
      mplayer -really-quiet ~/Music/17_shiki_no_uta.mp3
      sleep 10
    fi

    regex='.*(p|P)laylist.*'
    if [[ $response =~ $regex ]] ; then
      ./say.sh "playing nujabes playlist"
      mplayer -really-quiet -shuffle -playlist ~/Music/playlist.txt 
      sleep 10
    fi

done
