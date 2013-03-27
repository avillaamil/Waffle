import org.json.*;

String baseURL = "http://api.nytimes.com/svc/search/v1/article";
String apiKey = "5dd7a51804ba806122f0c98eaa3c26bf:13:66899748";

void setup() {

size(500,300);

String[] words = {"Japan", "China", "South+Korea", "North+Korea", "India"};
color[] colors = {#FF0000, #00FF00, #0000FF, #FF3300, #FF9900};

int barSize = 25;
int startY = 80;

String start = "19940101";
String end = "19960101";

for (int i = 0; i < words.length; i++) {
   int freq = getArticleKeywordCount( words[i], start, end);
   fill(colors[i]);
   rect(0, startY + (barSize * i), freq/20, barSize);
};
};

void draw() {

};

int getArticleKeywordCount(String word, String beginDate, String endDate) {
String request = baseURL + "?query=" + word + "&begin_date=" + beginDate + "&end_date=" + endDate + "&api-key=" + apiKey;
String result = join( loadStrings( request ), "");

int total = 0;

try {
JSONObject nytData = new JSONObject(join(loadStrings(request), ""));
JSONArray results = nytData.getJSONArray("results");
total = nytData.getInt("total");
println ("There were " + total + " occurences of the term " + word + " between " + beginDate + " and " + endDate);
}
catch (JSONException e) {
println ("There was an error parsing the JSONObject.");
};

return(total);
};
