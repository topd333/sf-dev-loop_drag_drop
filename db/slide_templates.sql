INSERT INTO `slide_templates` (`id`, `name`, `description`, `listed`,
`markup`, `organization_id`, `created_at`, `updated_at`, `hook_list`)
VALUES
(1, 'Full Screen Image', 'Single image scaled to fit the screen.', 1,
'<!DOCTYPE html>\n<html>\n<head>\n <style>\n html, body {\n
position:absolute;\n margin: 0px;\n width: 1920px;\n
height: 1080px;\n overflow: hidden;\n background-color: black;\n
}\n\n .fullIMG {\n position: absolute;\n width: 100%;\n
height: auto;\n }\n </style>\n</head>\n<body>\n <img
class="fullIMG" src="__SRC1__"></img>\n</body>\n</html>', 0, '2015-01-29
16:51:12', '2015-01-29 17:35:15', '---\n- :hook: __SRC1__\n :description:
The main image\n'),
(2, 'Full Screen Video', 'Single video scaled to fit the screen.', 1,
'<!DOCTYPE html>\n<html>\n<head>\n <style>\n html, body {\n
position: absolute;\n margin: 0px;\n width: 1920px;\n
height: 1080px;\n overflow: hidden;\n background-color: black;\n
}\n\n .fullVID {\n position: absolute;\n width: 100%;\n
\n }\n </style>\n</head>\n<body>\n <div class="fullVID
vidPlayable" data-src="__SRC1__"></div>\n</body>\n</html>', 0, '2015-01-29
16:51:12', '2015-01-29 17:35:45', '---\n- :hook: __SRC1__\n :description:
The main video\n'),
(3, 'Full Screen Image With RSS Ticker', 'Single image scaled to fit the
screen. Rss ticker on the bottom', 1, '<!DOCTYPE html>\n<html>\n<head>\n
<style>\n html, body {\n position:absolute;\n margin: 0px;\n
width: 1920px;\n height: 1080px;\n overflow: hidden;\n
background-color: black;\n }\n\n .fullIMG {\n height: 90%;\n
width: auto;\n }\n\n .rsswrapper {\n color: white;\n }\n
</style>\n</head>\n<body>\n <img class="fullIMG" src="__SRC1__"></img>\n
<div class="rsswrapper"><a class="twitter-timeline" data-dnt="true"
href="https://twitter.com/jonnysun"
data-widget-id="573582266921693184">Tweets by
@jonnysun</a>\n<script>!function(d,s,id){var
js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?''http'':''https'';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>\n</div>\n
<script src="__INCLUDE__JQ1.11.2__"></script>\n
//$(''.rsswrapper'').html(''newstuff'');\n</script>\n</body>\n</html>', 0,
'2015-01-29 16:51:12', '2015-01-29 17:35:15', '---\r\n- :hook:
__SRC1__\r\n :description: The main image\r\n');
