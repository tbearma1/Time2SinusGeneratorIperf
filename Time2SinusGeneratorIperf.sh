#!/bin/bash

iperf3serverip=X.X.X.X
iperf3serverport=YYYY
mult=2500
offs=3000 #Kbit/s
iperf3session=60 #sec
pi=`echo "4*a(1)" | bc -l`
#testhour=0
#testmin=0


while true; do
  #get the hours and minutes for bw-calculation
  hour=$(echo `date +%H` | sed 's/^0//')
  #hour=$testhour 
  min=$(echo `date +%M` | sed 's/^0//')
  #min=$testmin 

  grad=`echo "(15*$hour)+(0.25*($min+1))" | bc`
  rad=`echo "$grad*($pi/180)" | bc -l`
  sin=`echo "s($rad)" | bc -l`
  res_m=`echo "$sin*$mult" | bc`
  iperf3valfloat=`echo "$res_m+$offs" | bc`
  iperf3val="`printf '%.*f' 0 $iperf3valfloat`K"
  echo "HOUR: $hour MINUTE: $min GRAD: $grad RAD: $rad SIN: $sin RES_M: $res_m IPERF3VAL: $iperf3val"

  #MAINCMD
  iperf3 -c $iperf3serverip -t $iperf3session -b $iperf3val -p $iperf3serverport

  #TESTING
#  if [ $testmin -eq 59 ]
#  then
#    testmin=0
#    if [ $testhour -eq 23 ]
#    then
#      testhour=0
#    else
#      testhour=$((testhour + 1))
#    fi
#  else
#    testmin=$((testmin + 1))
#  fi

#  sleep $iperf3session

done
