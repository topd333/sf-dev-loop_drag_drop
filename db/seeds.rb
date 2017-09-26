# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

sforg = Organization.find_or_create_by!(name: "Screenfluence Admin Organization",
  email: "adam@screenfluence.com",
  phone: 6472290848,
  fname: "Adam",
  lname: "Fontana",
  address1: "303-542 Mount Pleasant Road",
  city: "Toronto",
  province: "Ontario",
  postalcode: "M4S2M6",
  baddress1: "303-542 Mount Pleasant Road",
  bcity: "Toronto",
  bprovince: "Ontario",
  bpostalcode: "M4S2M6"
)

User.create!(name: "Regular User Example",
    email: "regexample@screenfluence.com",
    password: "foobar",
    password_confirmation: "foobar",
    organization_id: sforg.id,
    default_slide_duration: 20000)

User.create!(name: "Org Admin Example",
    email: "orgadmin@screenfluence.com",
    password: "foobar",
    password_confirmation: "foobar",
    orgadmin: true,
    organization_id: sforg.id,
    default_slide_duration: 20000)

User.create!(name: "SOAdmin Example",
    email: "sfadmin@screenfluence.com",
    password: "foobar",
    password_confirmation: "foobar",
    soadmin: true,
    orgadmin: true,
    organization_id: sforg.id,
    default_slide_duration: 20000)


SlideTemplate.create!([
  {id: 1, name: "Full Screen Image", description: "Single image scaled to fit the screen.", listed: true, markup: "<!DOCTYPE html>\n<html>\n<head>\n <style>\n html, body {\n \nposition:absolute;\n margin: 0px;\n width: 1920px;\n \nheight: 1080px;\n overflow: hidden;\n background-color: black;\n \n}\n\n .fullIMG {\n position: absolute;\n width: 100%;\n \nheight: auto;\n }\n </style>\n</head>\n<body>\n <img \nclass=\"fullIMG\" src=\"__SRC1__\"></img>\n</body>\n</html>", organization_id: 0, hook_list: [{:hook=>"__SRC1__", :description=>"The main image source"}]},
  {id: 2, name: "Full Screen Video", description: "Single video scaled to fit the screen.", listed: true, markup: "<!DOCTYPE html>\n<html>\n<head>\n <style>\n html, body {\n \nposition: absolute;\n margin: 0px;\n width: 1920px;\n \nheight: 1080px;\n overflow: hidden;\n background-color: black;\n \n}\n\n .fullVID {\n position: absolute;\n width: 100%;\n \n\n }\n </style>\n</head>\n<body>\n <div class=\"fullVID \nvidPlayable\" data-src=\"__SRC1__\"></div>\n</body>\n</html>", organization_id: 0, hook_list: [{:hook=>"__SRC1__", :description=>"The main video source"}]}
])
