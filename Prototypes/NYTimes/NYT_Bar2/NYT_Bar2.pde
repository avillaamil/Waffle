

/*

 NYTimes API Graph Maker
 
 February, 2009
 blprnt@blprnt.com
 
 This is a simple interface to visualize the occurence of various words in the NYTimes database over time. 
 This particular version displays the results as a simple bar graph, like this:
 http://www.flickr.com/photos/blprnt/3256480403/
 
 For more information on the NYTimes API, visit http://developer.nytimes.com/
 
 */

import processing.opengl.*;
import org.json.*;

String baseURL = "http://api.nytimes.com/svc/search/v1/article";                  //Base URL for the NYT Article Search API
String apiKey = "5dd7a51804ba806122f0c98eaa3c26bf:13:66899748";                   //Enter your API Key here (http://developer.nytimes.com/)
String facetString = "org_facet";                                                 //Type(s) of facet to include in the search

int maxVal = 0;                                                                    //Keeps track of the maximum returned value over the all terms
int localMax = 0;                                                                  //Keeps track of the maximum returned value over the each term
int totalMonths = 0;                                                               //Counter for months to be drawn
float drawHeight = 0.65;                                                           //Portion of the screen height that the largest bar takes up

int border = 1;                                                                    //Border between bars
int lastTotal = 0;     

int s = 2006;                                                                      //Start Year
int e = 2008;                                                                      //End Year
String[] words = {"japan", "china"};                                               //Search Terms
color[] colours = { #400101, #8C4303};                                             //Graph Colours
color textColor = #D98D30;                                                        
color backColor = #F2F2F2;
color curColor;

boolean refresh = false;                                                           //Determines wether each term has it's own max value

void setup() {
  
  //Load the font to be used in text display
  PFont font;
  font = loadFont("SourceSansPro-Black-48.vlw");
  
  textFont(font); 
  
  //Set the size of the stage & set the background
  size(3000,1000);
  frameRate(60);
  background(backColor);
  smooth();
  
  //Draw key
  textSize(24);
  for (int i = 0; i < words.length; i++) {
    fill(colours[i]);
    text(words[i],25, 45 + (i * 30));
  };
  fill(textColor);
  text(s + "-" + e, 25, 45 + (words.length * 30));
  
  //For each keyword, request a TimesDataChunk and draw it.
  for (int i = 0; i < words.length; i++) {
    localMax = 0;
    totalMonths = 0;
    fill(colours[i]);
    curColor = colours[i];
    TimesDataChunk[] months = buildMonthArray(words[i], s, e);
    drawMonths(months);
    if (refresh) maxVal = 0;
  };  

  //Save out an image when the whole process is finished
  save(words[0] + "_" + s + "_" + e + ".png");
}

void draw() {
  
};

/*

drawMonths
- Takes an array of TimesDataChunks and renders them to the screen.

*/

void drawMonths(TimesDataChunk[] monthArray) {
 
  float xinc = float(width)/totalMonths;
  
  noStroke();
  
  //Draw each month as a bar
  for (int i = 0; i < totalMonths; i++) {
    
    color c = color(red(curColor), green(curColor), blue(curColor), random(100,255));
    fill(c);
    TimesDataChunk dc = monthArray[i];
    float h = float(dc.total)/float(maxVal);
    rect(float(i) * xinc, height, xinc, -h * height * drawHeight);
    
    float y = height - ( h * height * drawHeight);
    float x = float(i) * xinc;

    if (dc.isSpike) {
      
      //Mark maximum points
      rect(x, y - (xinc * 2), xinc/2, xinc/2);
     
      String s = dc.cmonth + "/" + dc.cyear;
      
      pushMatrix();
      translate(x + xinc/2, y - (xinc * 2));
      
      //DRAW DATE
      rotate(-PI/2);
      fill(textColor);
      textSize(max(xinc/2, 10));
      text(s, 0,0);
 
      translate( 50, 0);
      //DRAW TERMS
      
      if (dc.facetStrings.length > 0) {
        for (int j = 0; j < min(dc.facetStrings.length,3); j++) {
          color c2 = color(red(textColor), green(textColor), blue(textColor), random(100,150));
          fill(c2);
          String t = dc.facetStrings[j];
          textSize(random(8,12));
          pushMatrix();
          translate(0,0);
          rotate( random(-0.5, 0.5) );
          text (t, random(10), 0);
          popMatrix();
        };
      };
      
      popMatrix();
     
    };
  };

};

/*

buildMonthArray
- Makes a series of calls to getChunk to fill an array with TimesDataChunks
- Formats dated in required way

*/

TimesDataChunk[] buildMonthArray(String word, int startYear, int endYear) {
  //Find out how many months are going to be stored
  int months = (endYear - startYear) * 12;
  TimesDataChunk[] mArray = new TimesDataChunk[months];
  for (int j = 0; j < months; j++) {
   
    int i = j % 12;
    int y = startYear +  floor(j / 12);                                //GET YEAR
    String m = (i + 1 < 10) ? ("0" + str(int(i) + 1)):str(i + 1);      //GET MONTH
    
    totalMonths ++;
    
    TimesDataChunk dc2 = getChunk(word, str(y), m);                    //REQUEST DATA CHUNK
    mArray[j] = dc2;                                                   //ADD DATA CHUNK TO MONTH ARRAY
    
    println ("PROCESSED " + j + " OF " + months);
  };
  return(mArray);
};

/*

getChunk
- Makes a request to the NYT Article Search API and returns a TimessDataChunk

*/

TimesDataChunk getChunk(String word, String y, String m) {
  String url = baseURL + "?query=" + word + "%20publication_year:[" + y + "]%20publication_month:[" + m + "]&fields=+&facets=" + facetString + "&api-key=" + apiKey;
  println(url);
  
  TimesDataChunk dc = new TimesDataChunk();
  try { 
    JSONObject nytData = new JSONObject(join(loadStrings(url), ""));  
    JSONObject facets = nytData.getJSONObject("facets");
    dc.facets = facets.getJSONArray("org_facet");
    
    dc.facetStrings = new String[dc.facets.length()];
    for (int i = 0; i < dc.facets.length(); i++) {
      JSONObject o = (JSONObject) dc.facets.get(i);
      dc.facetStrings[i] = o.getString("term");
    };
  
    dc.total = int(nytData.getInt("total")); 
    if (dc.total > localMax) {
      localMax = min(dc.total, 3000);
      if (localMax > maxVal) maxVal = localMax;
      
    };
    
    if (dc.total > float(lastTotal) * 1.2) {
      dc.isSpike = true;
    };
    lastTotal = dc.total;
    dc.cyear =  y;
    dc.cmonth = m;   
  }  
  catch (JSONException e) {  
    println (e.toString());  
  } 
  
  return(dc);
};




