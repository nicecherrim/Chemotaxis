PImage devil;//image of devil
PImage angel;//image of angel

int angelCount, devilCount; //used to track angel/devils among all objects
int devils = (int)((Math.random()*6)+1); //used in the end to randomly determine how many devils there will be, from 1-6

Bubbles [] players;

void setup (){
  size(750,750);
  players = new Bubbles[100];
  for(int i = 0; i < players.length; i++) {
    players[i] = new Bubbles();
  }
  devil = loadImage("https://github.com/nicecherrim/Chemotaxis/blob/master/devil.png?raw=true", "png");
  angel = loadImage("https://github.com/nicecherrim/Chemotaxis/blob/master/angel.png?raw=true", "png");
}

void draw() {
  clear();
  background(200);
  for(int i = 0; i < players.length; i++) {
    players[i].rise();
    players[i].show();
    players[i].walk();
    players[i].popped();
    players[0].counter();
    players[i].addFriend();
    //takes the first couple of elements to make devils needed
    if(i <= devils) {
      players[i].myFriend = false;
    }
  }
}

class Bubbles {
  //define variables
   int myX, myY, mySize, myColor;
   double mySpeed, myDownVel, myGravity;
   boolean myFriend, myPopped, myCounted;

//constructor - the initializer for objects
//dont change the vars in the constructor  
  Bubbles() {
    //initialize all ur vars
    myX = (int)(Math.random()*750);
    myY = (int)((Math.random()*851));
    mySize = (int)(Math.random()*131+30);
    mySpeed = mySize/23;
    myColor = color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256),(int)((Math.random()*81)+20));
    myFriend = true;//determines if bubble will hold angel or devil
    myPopped = false;
    myDownVel = 0; //used to create falling effect
    myGravity = 0.5; //used to create falling effect
    myCounted = false; //once it becomes true, counters will not count current instance of the object anymore
  }
  
//member function
//seperate different fucntions, dont put too many things in one function
//what the obejct does
  void show(){
  //show bubbles
    noStroke();
    fill(myColor);
    ellipse(myX, myY, mySize, mySize);
  }
  
  void rise() {
    //move bubbles up
    myY = (int)(myY - mySpeed);
    if (myY < -50) {
      myY = (int)(Math.random()*50+750);
    }
  }
  
  void walk()  {
    //move bubbles left and right
   myX += ((int)(Math.random()*7)-3);
   if(myX > 800) {
     myX += ((int)(Math.random())*6-6);
   }
   if(myX < 0) {
     myX += ((int)(Math.random())*6);
   }
  }
 
 void addFriend() {
   //adds either a devil or agnel in bubble
   if(myFriend == true) {
     image(angel, myX-(mySize/4), myY-(mySize/4), mySize/2, mySize/2);
     //fill(0,0,255, 50);
     //ellipse(myX, myY, mySize/2, mySize/2);
   } else {
     image(devil, myX-(mySize/4), myY-(mySize/4), mySize/2, mySize/2);
     //fill(255,0,0, 50);
     //ellipse(myX, myY, mySize/2, mySize/2); 
   }
 }
 
  void fall() {
    //accererates object friend down
    myDownVel += myGravity;
    myY += myDownVel;
  }
  
  void popped() {
    //registers pops with mouse click, "erases" (just makes it have full opacity) bubble, and adds frined dropped to counters
    if(dist(mouseX, mouseY, myX, myY) < mySize/2 && mousePressed == true) {
      myPopped = true;
     }
    if(myPopped == true) {
      if(myFriend == true && myCounted == false) {
        angelCount += 1;
        myCounted = true;
      } else if(myFriend == false && myCounted == false) {
        devilCount += 1;
        myCounted = true;
      }
      fall();
      myColor = color(255,0,0,0);
    }
  }
  
  void counter() {
    //text to display counters & dispalys "win" text
    textSize(30);
    //I don't know why the devils var is one off from the devilCount, the + 1 is a cheap fix
    if (devils + 1 == devilCount) {
      text("Yayay no more trouble makers (^o^)" , 50, 50);
    }
    text("devils dropped: " + devilCount, 50, 730);
    text("angels dropped: " + angelCount, 400, 730);
  }
}

//declare your objects above setup
//Dice ----
