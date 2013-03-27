import org.json.*;

String baseURL = "http://api.nytimes.com/svc/search/v1/article";
String articleApiKey = "5dd7a51804ba806122f0c98eaa3c26bf:13:66899748";

void setup() {
  //getOJArticles();
  getArticleKeywordCount("O.J.+Simpson", "19940101", "19960101" );
  getArticleKeywordCount("Olympics", "19940101", "19960101" );
  getArticleKeywordCount("Rwanda", "19940101", "19960101" );
}

void draw() {
  
}

void getOJArticles() {
  
  String request = baseURL + "?query=O.J.+Simpson&begin_date=19940101&end_date=19960101&api-key=" + articleApiKey;
  
  String result = join(loadStrings(request), "");
  
  try {
    JSONObject nytData = new JSONObject(join(loadStrings(request), ""));
    JSONArray results = nytData.getJSONArray("results");
    int total = nytData.getInt("total");
    println("There were " + total + " occurences of the term O.J. Simpson in 1994 & 1995");
  }
  catch (JSONException e) {
    println("There was an error parsing the JSONObject");
  }
  //println(result);
} 

int getArticleKeywordCount(String word, String beginDate, String endDate) {
  String request = baseURL + "?query=" + word + "&begin_date=" + beginDate + "&end_date=" + endDate + "&api-key=" + articleApiKey;
  String result = join(loadStrings(request), "");
  
  int total = 0;
  
  try {
    JSONObject nytData = new JSONObject(join(loadStrings(request), ""));
    JSONArray results = nytData.getJSONArray("results");
    total = nytData.getInt("total");
    println("There were " + total + " occurences of the term " + word + " between " + beginDate + " and " + endDate);
  }
  catch (JSONException e) {
     println("There was an error parsing the JSONObject");
  }
  
  return(total);
}
