

import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

import processing.sound.*;
SoundFile file;

ArrayList tweets;

int followerCount;
int FetchCount;
int fps=30;
int DrawCount;
float tX;
float tY;
int n=5;
String keyword = "@MKBHD";

ConfigurationBuilder cb = new ConfigurationBuilder();
Twitter twitterInstance;
Query queryForTwitter;
void setup() {
  String[] KEYS = loadStrings("setting.txt");
  String ConsumerKey = KEYS[0];
  String ConsumerSecret=KEYS[1];
  String AcessToken=  KEYS[2];
  String AccessTokenSecret=KEYS[3];
  frameRate(fps);
  cb.setOAuthConsumerKey(ConsumerKey);
  cb.setOAuthConsumerSecret(ConsumerSecret);
  cb.setOAuthAccessToken(AcessToken);
  cb.setOAuthAccessTokenSecret(AccessTokenSecret);

  twitterInstance = new TwitterFactory(cb.build()).getInstance();

  queryForTwitter = new Query(keyword);
  fullScreen();
  // size(800, 600);
  background(255);
  FetchTweets();
  file = new SoundFile(this, "twitternotificaiton.mp3");
  //declare var

  followerCount = 0;
  FetchCount=0;
  DrawCount=1;
  tX=width/2;
  tY=height/3;
}

void FetchTweets() {
  try {
    QueryResult result = twitterInstance.search(queryForTwitter);

    tweets = (ArrayList)result.getTweets();
  }
  catch(TwitterException te) {
    println("Couldn't connect"+te);
  }
}

int Follower(int i) {

  Status t =(Status)tweets.get(i);
  int fC = t.getUser().getFollowersCount();
  return(fC);
}

String timezone(int i) {
  Status t =(Status)tweets.get(i);
  String tZ = t.getUser().getTimeZone();
  return(tZ);
} 

String profileColor(int i) {
  Status t =(Status)tweets.get(i);
  String pc = t.getUser().  getProfileBackgroundColor() ;
  return(pc);
}

String tweetsText(int i) {
  Status t =(Status)tweets.get(i);
  String tt = t.getText() ;
  return(tt);
}



void draw() {
  fill(255, 7);
  noStroke();
  rect(0, 0, width, height);
  fill(0);
  text("search keyword :" + keyword, width/2, 20);
  for (int i =0; i<=24; i++) {
    fill(180);
    stroke(180, 10);
    line(i*width/24, 50, i*width/24, height-50);
    String gmt= "GMT"+(i-12);
    textAlign(CENTER);
    text(gmt, i*width/24, height-20);
  }
  
  if (FetchCount<(1500/fps)) {
    FetchCount+=1;
  } else if (FetchCount==(1500/fps)) {
    FetchTweets();
    //////////////////////////////////
    println(followerCount);

    if (followerCount<tweets.size()) {
      println(Follower(followerCount)+" from "+timezone(followerCount)+"#"+profileColor(followerCount)); 
      String pC ="#"+profileColor(followerCount);
      pC = "FF" + pC.substring(1);
      fill(unhex(pC));
      String str="1";
      String str2 ="0";
      if (timezone(followerCount)==null) {
        str ="0";
      }   
      if (str.equals(str2)) {
        tX=-100;
      } else if (timezone(followerCount).equals("International Date Line West")||timezone(followerCount).equals("Midway Island")||timezone(followerCount).equals("Samoa")||timezone(followerCount).equals("Nuku'alofa")) {
        tX=width/24;//GMT-11/GMT+13
      } else if (timezone(followerCount).equals("Hawaii")) {
        tX=width/12;//GMT-10
      } else if (timezone(followerCount).equals("Alaska")) {
        tX=width/8;//GMT-09
      } else if (timezone(followerCount).equals("Pacific Time (US & Canada)")||timezone(followerCount).equals("Tijuana")) {
        tX=width/6;//GMT-08
      } else if (timezone(followerCount).equals("Arizona")||timezone(followerCount).equals("Mountain Time (US & Canada)")||timezone(followerCount).equals("Chihuahua")||timezone(followerCount).equals("Mazatlan")) {
        tX=5*width/24;//GMT-07
      } else if (timezone(followerCount).equals("Central Time (US & Canada)")||timezone(followerCount).equals("Central America")||timezone(followerCount).equals("Guadalajara")||timezone(followerCount).equals("Mexico City")||timezone(followerCount).equals("Monterrey")||timezone(followerCount).equals("Saskatchewan")) {
        tX=width/4;//GMT-06
      } else if (timezone(followerCount).equals("Eastern Time (US & Canada)")||timezone(followerCount).equals("Bogota")||timezone(followerCount).equals("Lima")||timezone(followerCount).equals("Quito")||timezone(followerCount).equals("Caracas")) {
        tX=7*width/24;//GMT-05
      } else if (timezone(followerCount).equals("Indiana (East)")||timezone(followerCount).equals("Atlantic Time (Canada)")||timezone(followerCount).equals("La Paz")||timezone(followerCount).equals("Santiago")) {
        tX=width/3;//GMT-04
      } else if (timezone(followerCount).equals("Newfoundland")) {
        tX=8.5*width/24;//GMT-03:30
      } else if (timezone(followerCount).equals("Brasilia")||timezone(followerCount).equals("Buenos Aires")||timezone(followerCount).equals("Georgetown")||timezone(followerCount).equals("Greenland")) {
        tX=9*width/24;//GMT-03
      } else if (timezone(followerCount).equals("Mid-Atlantic")) {
        tX=10*width/24;//GMT-02
      } else if (timezone(followerCount).equals("Azores")||timezone(followerCount).equals("Cape Verde Is.")) {
        tX=11*width/24;//GMT-01
      } else if (timezone(followerCount).equals("Dublin")||timezone(followerCount).equals("Casablanca")||timezone(followerCount).equals("Edinburgh")||timezone(followerCount).equals("Lisbon")||timezone(followerCount).equals("London")||timezone(followerCount).equals("Monrovia")) {
        tX=12*width/24;//GMT-00
      } else if (timezone(followerCount).equals("Amsterdam")||timezone(followerCount).equals("Belgrade")||timezone(followerCount).equals("Berlin")||timezone(followerCount).equals("Bern")||timezone(followerCount).equals("Bratislava")||timezone(followerCount).equals("Brussels")||timezone(followerCount).equals("Budapest")||timezone(followerCount).equals("Copenhagen")||timezone(followerCount).equals("Ljubljana")||timezone(followerCount).equals("Madrid")||timezone(followerCount).equals("Paris")||timezone(followerCount).equals("Prague")||timezone(followerCount).equals("Rome")||timezone(followerCount).equals("Sarajevo")||timezone(followerCount).equals("Skopje")||timezone(followerCount).equals("Stockholm")||timezone(followerCount).equals("Vienna")||timezone(followerCount).equals("Warsaw")||timezone(followerCount).equals("West Central Africa")||timezone(followerCount).equals("Zagreb")) {
        tX=13*width/24;//GMT+01
      } else if (timezone(followerCount).equals("Athens")||timezone(followerCount).equals("Bucharest")||timezone(followerCount).equals("Cairo")||timezone(followerCount).equals("Harare")||timezone(followerCount).equals("Helsinki")||timezone(followerCount).equals("Istanbul")||timezone(followerCount).equals("Jerusalem")||timezone(followerCount).equals("Kyiv")||timezone(followerCount).equals("Pretoria")||timezone(followerCount).equals("Riga")||timezone(followerCount).equals("Sofia")||timezone(followerCount).equals("Tallinn")||timezone(followerCount).equals("Vilnius")) {
        tX=14*width/24;//GMT+02
      } else if (timezone(followerCount).equals("Baghdad")||timezone(followerCount).equals("Kuwait")||timezone(followerCount).equals("Minsk")||timezone(followerCount).equals("Riyadh")) {
        tX=15*width/24;//GMT+03
      } else if (timezone(followerCount).equals("Abu Dhabi")||timezone(followerCount).equals("Baku")||timezone(followerCount).equals("Moscow")||timezone(followerCount).equals("Muscat")||timezone(followerCount).equals("St. Petersburg")||timezone(followerCount).equals("Tbilisi")||timezone(followerCount).equals("Volgograd")||timezone(followerCount).equals("Yerevan")) {
        tX=16*width/24;//GMT+04
      } else if (timezone(followerCount).equals("Kabul")) {
        tX=16.5*width/24;//GMT+04:30
      } else if (timezone(followerCount).equals("Islamabad")||timezone(followerCount).equals("Karachi")||timezone(followerCount).equals("Tashkent")) {
        tX=17*width/24;//GMT+05
      } else if (timezone(followerCount).equals("Chennai")||timezone(followerCount).equals("Kolkata")||timezone(followerCount).equals("Mumbai")||timezone(followerCount).equals("New Delhi")) {
        tX=17.5*width/24;//GMT+05:30
      } else if (timezone(followerCount).equals("Kathmandu")) {
        tX=17.75*width/24;   //GMT+05:45
      } else if (timezone(followerCount).equals("Almaty")||timezone(followerCount).equals("Astana")||timezone(followerCount).equals("Dhaka")||timezone(followerCount).equals("Ekaterinburg")||timezone(followerCount).equals("Sri Jayawardenepura")) {
        tX=18*width/24;//GMT+06
      } else if (timezone(followerCount).equals("Rangoon")) {
        tX=18.5*width/24;//GMT+06:30
      } else if (timezone(followerCount).equals("Bangkok")||timezone(followerCount).equals("Hanoi")||timezone(followerCount).equals("Jakarta")||timezone(followerCount).equals("Novosibirsk")) {
        tX=19*width/24;//GMT+07
      } else if (timezone(followerCount).equals("Beijing")||timezone(followerCount).equals("Chongqing")||timezone(followerCount).equals("Hong Kong")||timezone(followerCount).equals("Krasnoyarsk")||timezone(followerCount).equals("Kuala Lumpur")||timezone(followerCount).equals("Perth")||timezone(followerCount).equals("Singapore")||timezone(followerCount).equals("Taipei")||timezone(followerCount).equals("Ulaan Bataar")||timezone(followerCount).equals("Urumqi")) {
        tX=20*width/24;//GMT+08
      } else if (timezone(followerCount).equals("Irkutsk")||timezone(followerCount).equals("Osaka")||timezone(followerCount).equals("Sapporo")||timezone(followerCount).equals("Seoul")||timezone(followerCount).equals("Tokyo")) {
        tX=21*width/24;//GMT+09
      } else if (timezone(followerCount).equals("Adelaide")||timezone(followerCount).equals("Darwin")) {
        tX=21.5*width/24;//GMT+09:30
      } else if (timezone(followerCount).equals("Brisbane")||timezone(followerCount).equals("Canberra")||timezone(followerCount).equals("Guam")||timezone(followerCount).equals("Hobart")||timezone(followerCount).equals("Melbourne")||timezone(followerCount).equals("Port Moresby")||timezone(followerCount).equals("Sydney")||timezone(followerCount).equals("Yakutsk")) {
        tX=22*width/24;//GMT+10
      } else if (timezone(followerCount).equals("Solomon Is.")||timezone(followerCount).equals("Vladivostok")) {
        tX=23*width/24;//GMT+11
      } else if (timezone(followerCount).equals("Auckland")||timezone(followerCount).equals("Fiji")||timezone(followerCount).equals("Kamchatka")||timezone(followerCount).equals("Magadan")||timezone(followerCount).equals("Marshall Is.")||timezone(followerCount).equals("Wellington")) {
        tX=24*width/24;//GMT+11
      } else {
        tX=width;
        tY=height/3;
      }

      ellipse(tX+random(-width/48, width/48), tY, n*sqrt(Follower(followerCount)), n*sqrt(Follower(followerCount)));
      if (Follower(followerCount)>1500) {
        file.cue(10);
        file.play();
      }
      textAlign(CENTER);
      text(tweetsText(followerCount), tX+random(-width/48, (width/48)-50), random(height/2, height));
      followerCount+=1;
    } else if (followerCount==tweets.size()) {
      followerCount = 0;
    }

    //////////////////////////////////
    FetchCount=0;
  }
}
