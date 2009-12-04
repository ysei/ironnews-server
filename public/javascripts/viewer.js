
var viewer = {};
viewer.articleRecords   = null;
viewer.currentArticleId = null;
viewer.currentReadTimer = null;

viewer.initLayout = function() {
  var container  = $("#container");
  var controller = $("#controller");
  var browser    = $("#browser");

  var adjustLayout = function() {
    var window_width      = $(window).width();
    var window_height     = $(window).height();
    var controller_height = controller.outerHeight();

    container.width(window_width);
    container.height(window_height);
    controller.width(window_width);
    browser.width(window_width);
    browser.height(window_height - controller_height);
  };

  $(window).resize(adjustLayout);
  setTimeout(adjustLayout, 100); // Google Chromeで正常に動作させるために100msec遅延させる
};

viewer.showArticle = function(article_id) {
  var url   = viewer.articleRecords[article_id].url;
  var title = viewer.articleRecords[article_id].title;

  $("#browser").attr("src", url);
  $("#url").text(url);
  document.title = title;

  if ( viewer.currentReadTimer != null )
  {
    clearTimeout(viewer.currentReadTimer);
  }
  viewer.currentReadTimer = setTimeout(function() {
    viewer.addTagToCurrentArticle("既読");
  }, 3000);

  viewer.currentArticleId = article_id;
};

viewer.getArticleIndex = function(article_id) {
  var index = window.articleIds.indexOf(article_id);
  return (index >= 0 ? index : null);
};

viewer.getNextArticleId = function() {
  var index = viewer.getArticleIndex(viewer.currentArticleId);
  if ( index == null ) return null;
  if ( index >= window.articleIds.length - 1 ) return null;
  return window.articleIds[index + 1];
};

viewer.getPrevArticleId = function() {
  var index = viewer.getArticleIndex(viewer.currentArticleId);
  if ( index == null ) return null;
  if ( index <= 0 ) return null;
  return window.articleIds[index - 1];
};

viewer.loadArticles = function() {
  api.getInfo(window.articleIds, {
    success: function(data) {
      viewer.articleRecords = data;
      viewer.showArticle(window.articleIds[0]);
    }//,
  });
};

viewer.addTagToCurrentArticle = function(tag, success) {
  api.addTag(viewer.currentArticleId, tag, {success: success});
};

$(function() {
  viewer.initLayout();
  viewer.loadArticles();

  $("#next-article").click(function() {
    var article_id = viewer.getNextArticleId();
    if ( article_id != null ) viewer.showArticle(article_id);
    else alert("最後の記事です");
  });

  $("#prev-article").click(function() {
    var article_id = viewer.getPrevArticleId();
    if ( article_id != null ) viewer.showArticle(article_id);
    else alert("最初の記事です");
  });

  $("div.tags span").each(function() {
    $(this).click(function() {
      var tag = $(this).text();
      viewer.addTagToCurrentArticle(tag, function() { /*nop*/ });
    });
  });
});